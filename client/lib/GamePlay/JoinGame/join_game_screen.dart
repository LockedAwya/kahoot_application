import 'package:flutter/material.dart';
import '../WaitingRoom/waiting_room.dart';
import '../WaitingRoom/game_pin.dart';
import '../../utils/global_variables.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class JoinGameScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<JoinGameScreen> createState() => _JoinGameScreen();
}

class _JoinGameScreen extends State<JoinGameScreen> {
  final TextEditingController gameIdController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  // void initSocket() {
  //   socket = IO.io(
  //     'http://10.0.2.2:3003',
  //     IO.OptionBuilder()
  //         .setTransports(['websocket'])
  //         //.disableAutoConnect()
  //         // .setQuery(
  //         //     {'username': widget.username})
  //         .enableForceNew()
  //         .build(),
  //   );
  //   socket.connect();
  //   socket.onConnect(
  //       (data) => print('Connection established with id ${socket.id}'));
  //   socket.onConnectError((data) => print('Connect Error: $data'));
  //   socket.onDisconnect(
  //       (data) => print('Socket.IO server disconnected with id ${socket.id}'));
  // }

  @override
  void initState() {
    // TODO: implement initState
    //print("LMAO");
    super.initState();
    //setState(() => {initSocket()});
    //initSocket();
  }

  void cb(String notify, String username, String gameId) {}
  @override
  Widget build(BuildContext context) {
    // const double height = MediaQuery.of(context).size.height;
    // const double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[900],
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.only(bottom: 150.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
              child: Text(
                "Join a quiz game!",
                style: TextStyle(
                  height: 1.0,
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: TextField(
                controller: gameIdController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Game ID',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: TextField(
                controller: usernameController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 370,
              // padding:
              //     const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0)),
                ),
                child: const Text(
                  "Enter",
                  style: TextStyle(
                    height: 1.0,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => {
                  //username, socketId, gameId, cb
                  // setState(() => {
                  //       initSocket(),
                  //     }),
                  print("Lmao player"),

                  box.write("perspective", "player"),
                  //box.write("added-username")
                  box.write('gameData', {
                    "gameId": gameIdController.text,
                    "username": usernameController.text,
                    //"socketId": socket.id,
                  }),
                  print(box.read('gameData')),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GamePin()),
                  )
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    gameIdController.dispose();
    usernameController.dispose();
  }
}
