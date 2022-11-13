//import '../WaitingRoom/waiting_room.dart';
import 'package:flutter/material.dart';
import '../WaitingRoom/game_pin.dart';
//import '../../utils/routing_names.dart';
import '../../utils/global_variables.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  late int roomId;
  late String quizId;
  //late var gameData;

  void initSocket() {
    socket = IO.io(
      'http://127.0.0.1:3003', //http://10.0.2.2:3003 //http://127.0.0.1:3003
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
              onPressed: () => {
                print("Lmao"),
                initSocket(),
                roomId = random(1000000, 9999999),
                //initSocket(),
                box.write("gameData", {
                  "quizId": widget.quizId,
                  "roomId": roomId.toString(),
                }),
                box.write("perspective", "host"),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePin()),
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}
