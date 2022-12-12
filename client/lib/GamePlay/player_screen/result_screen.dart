import 'package:flutter/material.dart';
import '../score_board.dart';
import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../highscore_page.dart';
import 'package:untitled_folder/GamePlay/player_screen/player_screen.dart';
// import '../score_board.dart';
// import '../../api/index.dart';
import '../../utils/global_variables.dart';
import '../../utils/routing_names.dart';

class ResultScreen extends StatefulWidget {
  final String quizId;
  final int questionIndex;
  final String gamePin;
  final int timer;
  final int scorePerQuestion;
  const ResultScreen(
      {Key? key,
      required this.quizId,
      required this.questionIndex,
      required this.gamePin,
      required this.timer,
      required this.scorePerQuestion})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_read();
    print("Question index is: ");
    print(widget.questionIndex);
    //start = widget.timer;
    if (mounted) {
      if (box.read('perspective') == 'player') {
        //socket.emit("leave-game", box.read("gameData"));
        socket.on("game-deleted", (data) {
          print(data);
          print("Game is deleteddddd");
          Timer(Duration(seconds: 3), () {
            Navigator.pushNamed(context, SecretScreenView);
          });
        });
        //Navigator.pushNamed(context, SecretScreenView);
      }
      socket.once("move-players-to-question-preview", (data) {
        print(data);
        print("All players are moving to the next question now!!!!!");
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayerScreen(
                      //questionIndex: widget.questionIndex + 1,

                      quizId: widget.quizId,
                      questionIndex: widget.questionIndex + 1,
                      gamePin: widget.gamePin,
                      timer: widget.timer,
                      scorePerQuestion: widget.scorePerQuestion)));
          //Navigator.pop(context, widget.questionIndex + 1);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // appBar: AppBar(
      //   elevation: 0,
      //   leading: Container(),
      //   backgroundColor: Colors.deepPurpleAccent,
      //   actions: [
      //     InkWell(
      //       onTap: () {
      //         //Navigator.push(context, MaterialPageRoute(builder: (context) => const ScoreBoard()));
      //       },
      //       child: Container(
      //         width: 60,
      //         height: 6,
      //         margin: const EdgeInsets.all(10),
      //         alignment: Alignment.center,
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //           borderRadius: BorderRadius.circular(5.0),
      //         ),
      //         child: const Text(
      //           "Next",
      //           style: TextStyle(fontSize: 14, color: Colors.white),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Text(
          "Player name: ${box.read("gameData")["username"]}.\n${box.read("message_result")}",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
