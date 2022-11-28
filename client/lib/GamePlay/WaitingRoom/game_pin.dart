import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils/global_variables.dart';
import '../../utils/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../utils/stream_socket.dart';
import 'package:get/get.dart';
import '../JoinGame/join_game_screen.dart';
import '../../api/index.dart';
//import '../HostGame/host_game_play_screen.dart';
import '../host_screen/host_screen.dart';
import '../player_screen/player_screen.dart';
import 'dart:async';

class GamePin extends StatefulWidget {
  //final int gameId;
  //final String username;
  //var gameData;
  GamePin({Key? key}) : super(key: key);

  @override
  _GamePinState createState() => _GamePinState();
}

//dynamic findUser(int id) => GamePin.firstWhere((user) => user.id == id);

class _GamePinState extends State<GamePin> {
  List<dynamic> gamePin = [];
  //StreamSocket streamSocket = StreamSocket();
  //List<String> gamePin = []; //display "Waiting for player if there are no players"
  //late int gameId;
  StreamSocket streamSocket = StreamSocket();
  bool isGameLive = true;
  // int playersCount = 0;

  void initSocket() {
    if (box.read('perspective') == "host") {
      //gameData: gamePin, gameId, quizId
      //socket.emit("create-game", box.read("gameData"));

      socket.emitWithAck("create-game", box.read("gameData"), ack: (data) {
        print("The data is.....");
        print(data);
        //print(data1);
      });

      socket.on("user-left", (data) {
        String name = data['username'];
        print(gamePin);
        //print(name);
        // print("User with ${name} left");
        //gamePin.remove(gamePin[0]);
        dynamic res =
            gamePin.firstWhere((user) => user['username'] == data['username']);
        print(gamePin.indexOf(res));

        gamePin.removeAt(gamePin.indexOf(res));
        streamSocket.addResponse(gamePin);
      });
    }
    if (box.read('perspective') == "player") {
      socket.emit("add-player", {
        "username": box.read('gameData')['username'],
        "userId": box.read('gameData')['userId'],
        "gamePin": box.read('gameData')['gamePin'],
        "socketId": box.read('gameData')['socketId'],
      });
    }

    socket.on("player-added", (data) {
      //streamSocket.addResponse(gamePin);
      print(data);
      gamePin.add(data);
      streamSocket.addResponse(gamePin);
    });
    socket.on("game-deleted", (data) {
      print(data);
      print("Game is deleteddddd");
      Timer(Duration(seconds: 3), () {
        // Navigator.pushReplacement(
        //     //context, MaterialPageRoute(builder: (context) => HomeScreen()));
        //     Navigator.of(context).pop());
        Navigator.of(context).pop();
      });
    });
    socket.on("move-to-gameplay", (data) {
      // if (data["quizId"] is String) {
      //   print(data["quizId"]);
      // } else if (data["gamePin"] is int) {
      //   print(data["gamePin"]);
      // } else if (data["timer"] is int) {
      //   print(data["timer"]);
      // }
      print(data["gamePin"]);
      print(data["timer"]);
      //print(data["questionIndex"]);
      print(data["gamePin"]);
      print(data["scorePerQuestion"]);
      // print(data["timer"]);
      print("All players are moving to the game now!!!!!");
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PlayerScreen(
                    quizId: data["quizId"].toString(),
                    questionIndex: 0,
                    gamePin: data["gamePin"].toString(),
                    timer: data["timer"],
                    scorePerQuestion: data["scorePerQuestion"])));
      });
    });
  }

  // void goBack(BuildContext context) {
  //   Navigator.of(context).pop();
  // }

  @override
  void initState() {
    // TODO: implement initState
    //print("LMAO");
    super.initState();
    //initSocket();
    setState(() => {initSocket()});
  }

  // @override
  // void didUpdateWidget(GamePin oldWidget) {
  //   debugPrint('State didUpdateWidget');
  //   super.didUpdateWidget(oldWidget);
  //   initSocket();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamSocket.socketResponse,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // if (snapshot.data == false) {
          //   Navigator.of(context).pop();
          // }
          //print(snapshot.data);
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              elevation: 0,
              actions: [
                IconButton(
                  alignment: Alignment.center,
                  iconSize: 20,
                  onPressed: () async {
                    if (box.read('perspective') == 'host') {
                      socket.emit(
                          "delete-game", box.read("gameData")["gamePin"]);
                      gamePin = [];
                      var res =
                          await deleteGameApi(box.read("gameData")["gameId"]);
                      if (res?.statusCode == 200) {
                        print("Delete game successfully");
                      }
                      Navigator.of(context).pop();
                    }
                    if (box.read('perspective') == 'player') {
                      socket.emit("leave-game", box.read("gameData"));
                      //Get.to(JoinGameScreen());
                      Navigator.of(context).pop();
                    }
                    socket.dispose();
                    //streamSocket.dispose,
                    print(socket.connected);
                    box.remove("gameData");

                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => super.widget));
                  },
                  icon: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      )),
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Game pin: ${box.read('gameData')['gamePin']}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: box.read('perspective') == 'host'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/ic_user.png',
                                      width: 16,
                                      height: 16,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      snapshot.data == null
                                          ? "0"
                                          : snapshot.data.length.toString(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  'Kahoot!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24),
                                ),
                              ),
                              Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                child: InkWell(
                                  onTap: () async {
                                    //var questionList =
                                    // await getQuestionsByQuizId(
                                    //     box.read('gameData')['quizId']);
                                    // getQuestionsByQuizId(
                                    //     box.read('gameData')['quizId']);
                                    socket.emit("start-game", {
                                      "quizId": box
                                          .read('gameData')['quizId']
                                          .toString(),
                                      "gamePin": box
                                          .read('gameData')['gamePin']
                                          .toString(),
                                      "scorePerQuestion": box.read(
                                          "quizDetails")["scorePerQuestion"],
                                      "timer": box.read("quizDetails")["timer"],
                                    });
                                    // if (questionList?.s == 200) {
                                    //   socket.emit("start-game", {
                                    //     "quizId":
                                    //         box.read('gameData')['quizId'],
                                    //     "gamePin":
                                    //         box.read('gameData')['gamePin']
                                    //   });
                                    // }
                                    //call game api by game pin
                                    //if status = 200 call the loop below
                                    // for (int i = 0; i < snapshot.data.length; i++) {
                                    //create player result api here //snapshot.data.length
                                    /**
                                       * playerId: string (from game.playerList)
                                       * gamePin: string 
                                       * playerName: string (from game.playerList)
                                       * score: int (0)
                                       * answers: array (empty)
                                       */
                                    // }
                                    // socket.emit("start-game", {
                                    //   "quizId": "",
                                    //   "gamePin": box.read('gameData')['gamePin']
                                    // });
                                    Timer(Duration(seconds: 3), () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HostScreen(questionIndex: 0)),
                                      );
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: Text("Start",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  //alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: StreamBuilder(
                    stream: streamSocket.getResponse,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return gamePin.isNotEmpty
                          ? GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      childAspectRatio: 80 / 36),
                              itemBuilder: (_, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white),
                                  child:
                                      // Text(gamePin[index],
                                      //     maxLines: 2,
                                      //     softWrap: true,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: const TextStyle(
                                      //         fontSize: 10,
                                      //         fontWeight: FontWeight.normal)),
                                      Text(snapshot.data[index]["username"],
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal)),
                                );
                              },
                              itemCount: gamePin.length,
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Wating for player.....",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            );
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    streamSocket.dispose();
  }
}
