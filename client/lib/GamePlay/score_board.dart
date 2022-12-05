import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './highscore_page.dart';
import 'package:untitled_folder/model/score_board_model.dart';
import 'package:untitled_folder/GamePlay/player_screen/player_screen.dart';
import '../../utils/global_variables.dart';
import './host_screen/host_screen.dart';
import 'dart:async';
import 'dart:math' as math;
import '../../utils/stream_socket.dart';
import '../../utils/routing_names.dart';
import '../api/index.dart';

class ScoreBoard extends StatefulWidget {
  final int questionIndex;
  final String quizId;
  final String gamePin;
  final int timer;
  final int scorePerQuestion;
  const ScoreBoard(
      {Key? key,
      this.quizId = "",
      required this.questionIndex,
      this.gamePin = "",
      this.timer = 0,
      this.scorePerQuestion = 0})
      : super(key: key);

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  List<ScoreBoardModel> listScore = [
    // ScoreBoardModel(namePlay: 'Player1', score: '897'),
    // ScoreBoardModel(namePlay: 'LockedAway00', score: '855', me: true),
    // ScoreBoardModel(namePlay: 'Player2', score: '810'),
    // ScoreBoardModel(namePlay: 'Player4', score: '0'),
    // ScoreBoardModel(
    //   namePlay: 'Player3',
    //   score: '0',
    // )
  ];
  int countClick = 0;
  StreamSocket streamSocket = StreamSocket();

  @override
  void initState() {
    // TODO: implement initState
    // print("question index is");
    // print(widget.questionIndex);
    super.initState();
    //_read();
    if (mounted) {
      //setState(() => _products = []);
      //setState(() => {init()});
      init();
    }
    //setState(() => {init()});
  }

  // _read() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var values = prefs.getInt("point") ?? 0;
  //   if (values != null) {
  //     setState(() {
  //       countClick = values;
  //     });
  //   }
  //   print('read: $values');
  // }

  void init() {
    // _read();
    //if (box.read("perspective") == "host") {
    //if (box.read("perspective") == "host") {
    socket.on("move-all-to-leaderboard", (data) {
      print("The current leaderboard is....");
      print(data);
      for (int i = 0; i < data["currentLeaderboard"].length; i++) {
        listScore.add(ScoreBoardModel(
            namePlay: data["currentLeaderboard"][i]["playerName"],
            score: data["currentLeaderboard"][i]["playerPoints"].toString(),
            me: data["currentLeaderboard"][i]["playerName"] ==
                    box.read("gameData")["username"]
                ? true
                : false));
      }
      box.write("top-players", listScore);
      print(box.read("top-players"));
      streamSocket.addResponse(listScore);
    });
    //}
    // if (box.read("perspective") == "player") {
    //   Timer(Duration(seconds: 3), () {
    //     socket.on("move-all-to-leaderboard", (data) {
    //       print("The current leaderboard is....");
    //       print(data);
    //       for (int i = 0; i < data["currentLeaderboard"].length; i++) {
    //         listScore.add(ScoreBoardModel(
    //             namePlay: data["currentLeaderboard"][i]["playerName"],
    //             score:
    //                 data["currentLeaderboard"][i]["playerPoints"].toString()));
    //       }
    //       streamSocket.addResponse(listScore);
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamSocket.socketResponse,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
            backgroundColor: Colors.deepPurpleAccent,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              leadingWidth: 140,
              backgroundColor: Colors.deepPurpleAccent,
              leading: const Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Scoreboard",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )),
              actions: [
                InkWell(
                  onTap: () async {
                    if (widget.questionIndex + 1 ==
                        box.read("quizDetails")['questionList'].length) {
                      //Navigator.pushNamed(context, SecretScreenView);

                      socket.emit(
                          "delete-game", box.read("gameData")["gamePin"]);
                      var res =
                          await deleteGameApi(box.read("gameData")["gameId"]);
                      if (res?.statusCode == 200) {
                        //Navigator.pushNamed(context, SecretScreenView);
                        print("Delete game successfully");
                      }
                      socket.dispose();
                      Navigator.pushNamed(context, SecretScreenView);

                      //return;
                    } else {
                      socket.emit("move-to-question-preview", {
                        "currentquestionIndex": widget.questionIndex,
                        "gamePin": box.read("gameData")["gamePin"]
                      });
                      // Timer(Duration(seconds: 5), () {
                      //   socket.emit("move-to-question-preview", {
                      //     "currentquestionIndex": widget.questionIndex,
                      //     "gamePin": box.read("gameData")["gamePin"]
                      //   });
                      // });
                      Timer(Duration(seconds: 3), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HostScreen(
                                    questionIndex: widget.questionIndex + 1)));
                      });

                      // socket.emit("start-game", {
                      //   "quizId": box.read('gameData')['quizId'],
                      //   "gamePin": box.read('gameData')['gamePin'],
                      // });
                      // else {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => PlayerScreen(
                      //               questionIndex: widget.questionIndex + 1)));
                      // }
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      alignment: Alignment.center,
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                          //when the game is over
                          widget.questionIndex + 1 ==
                                  box.read("quizDetails")['questionList'].length
                              ? "Quit Game"
                              : "Next",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black))),
                )
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data[index];
                    return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 40,
                        color:
                            item.me == true ? Colors.white : Colors.transparent,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                    color: item.me == true
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Text(
                                item.namePlay ?? "",
                                style: TextStyle(
                                    color: item.me == true
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              item.score ?? "",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: item.me == true
                                      ? Colors.black
                                      : Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ));
                  }),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
