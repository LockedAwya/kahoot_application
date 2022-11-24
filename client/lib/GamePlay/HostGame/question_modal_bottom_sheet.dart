//import '../WaitingRoom/waiting_room.dart';
import 'package:flutter/material.dart';
import '../WaitingRoom/game_pin.dart';
//import '../../utils/routing_names.dart';
import '../../utils/global_variables.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../api/index.dart';

class QuestionModalBottomSheet extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  final String quizId;
  // final String quizName;
  // final String quizDescription;
  // final String quizCreator;
  const QuestionModalBottomSheet({required this.quizId});
  @override
  State<QuestionModalBottomSheet> createState() => _QuestionModalBottomSheet();
}

class _QuestionModalBottomSheet extends State<QuestionModalBottomSheet> {
  late int gamePin;
  late String quizId;
  //late var gameData;

  void initSocket() {
    socket = IO.io(
      'http://127.0.0.1:3000', //http://10.0.2.2:3003 //http://127.0.0.1:3003
      IO.OptionBuilder()
          .setTransports(['websocket'])
          //.disableAutoConnect()
          // .setQuery(
          //     {'username': widget.username})
          .enableForceNew()
          .build(),
    );
    socket.connect();
    socket.onConnect(
        (data) => print('Connection established with id ${socket.id}'));
    socket.onConnectError((data) => print('Connect Error: $data'));
    socket.onDisconnect((data) =>
        print('Socket.IO server (room) disconnected with id ${socket.id}'));
  }

  // void createGame() async {
  //   var res = await createGameApi(userId, "", roomId.toString(), [], []);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0)),
              ),
              child: const Text(
                "Start",
                style: TextStyle(
                  height: 1.0,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                print("Lmao");
                initSocket();
                gamePin = random(1000000, 9999999);

                //             createGameApi(String hostId, String quizId, String pin,
                // String playerList, String playerResultList)
                var res = await createGameApi(userId, widget.quizId,
                    gamePin.toString(), [] as dynamic, [] as dynamic);
                print(res?.data);
                if (res?.statusCode == 200) {
                  box.write("gameData", {
                    "quizId": widget.quizId,
                    "gamePin": gamePin.toString(),
                    "gameId": res?.data["_id"],
                  });
                  box.write("perspective", "host");
                  print(box.read("gameData"));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GamePin()));
                } else {
                  print(res?.statusMessage);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
