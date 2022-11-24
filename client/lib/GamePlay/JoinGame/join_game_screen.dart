import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../WaitingRoom/waiting_room.dart';
import '../WaitingRoom/game_pin.dart';
import '../../utils/global_variables.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../utils/stream_socket.dart';
import 'dart:async';
import '../../utils/router.dart';
import '../../api/index.dart';
import 'package:oktoast/oktoast.dart';

class JoinGameScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<JoinGameScreen> createState() => _JoinGameScreen();
}

class _JoinGameScreen extends State<JoinGameScreen> {
  final TextEditingController roomIdController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  StreamSocket streamSocket = StreamSocket();
  var completer = Completer<dynamic>();
  //completer = Completer();
  String msg = "test";

  @override
  void initState() {
    // TODO: implement initState
    //print("LMAO");
    super.initState();
  }

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

  //void cb(String notify, String username, String gameId) {}
  void joinRoomValidation(BuildContext context) async {
    final completer = new Completer();
    socket.on(
        "no-room-available",
        (data) => {
              //print(data),
              //streamSocket.addResponse(data),
              completer.complete(data),
              socket.dispose,
            });
    socket.on(
        "duplicated-username",
        (data) => {
              //print(data),
              //streamSocket.addResponse(data),
              completer.complete(data),
              socket.dispose
            });
    // new Timer(Duration(seconds: 3), () {
    //   print("Yeah, this line is printed after 3 seconds");
    //   completer.complete("you should see me final");
    // });
    completer.future
        .then((dynamic result) => {
              msg = result,
            })
        .whenComplete(() => {
              //print(msg),
              if (msg == null)
                {
                  box.write("perspective", "player"),
                  //box.write("added-username")
                  box.write('gameData', {
                    "roomId": roomIdController.text,
                    "username": usernameController.text,
                    //"socketId": socket.id,
                  }),
                  print(box.read('gameData')),
                  //Get.to(GamePin()),
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => GamePin())),
                  //Navigator.of(context).pushNamed("/waiting_room"),
                }
              else
                {
                  print("Cannot go!!!"),
                  print(msg),
                }
              // Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => GamePin())),
            });
    //return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    // const double height = MediaQuery.of(context).size.height;
    // const double width = MediaQuery.of(context).size.width;
    // return StreamBuilder(
    //     stream: streamSocket.socketResponse,
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                controller: roomIdController,
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
                onPressed: () async {
                  initSocket();
                  print("Data is " + msg);
                  var res = await addPlayerApi(roomIdController.text, socket.id,
                      usernameController.text);
                  if (res?.statusCode == 200) {
                    box.write("perspective", "player");
                    box.write('gameData', {
                      "gamePin": roomIdController.text,
                      "username": usernameController.text,
                      "socketId": socket.id,
                    });
                    print(box.read('gameData'));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GamePin()));
                  } else {
                    showToast("Invalid game pin",
                        position: ToastPosition.bottom);
                    //print("Invalid game pin");
                  }
                  // )
                },
              ),
            ),
          ],
        ),
      ),
    );
    // });
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
    usernameController.dispose();
  }
}
