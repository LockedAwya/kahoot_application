import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../highscore_page.dart';
import 'package:untitled_folder/GamePlay/player_screen/initial_screen.dart';
import '../score_board.dart';
import '../../api/index.dart';
import '../../utils/global_variables.dart';

class PlayerScreen extends StatefulWidget {
  //const PlayerScreen({Key? key}) : super(key: key);
  final String quizId;
  final int questionIndex;
  final String gamePin;
  final int timer;
  final int scorePerQuestion;
  const PlayerScreen(
      {Key? key,
      required this.quizId,
      required this.questionIndex,
      required this.gamePin,
      required this.timer,
      required this.scorePerQuestion})
      : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  Timer? _timer;
  late int start;
  //final key = 'point';
  int value = 0;
  String choice = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_read();
    print("Question index is: ");
    print(widget.questionIndex);
    //start = widget.timer;
    if (mounted) {
      startTimer();
    }
  }

  // _read() async {
  //   // final prefs = await SharedPreferences.getInstance();
  //   // var values = prefs.getInt(key) ?? 0;
  //   // if (value != null) {
  //   //   setState(() {
  //   //     value = values;
  //   //   });
  //   // }
  //   // print('read: $value');
  // }

  void startTimer() {
    // print("Question index is: ");
    // print(widget.questionIndex);
    start = widget.timer;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScoreBoard(
                      quizId: widget.quizId,
                      questionIndex: widget.questionIndex,
                      gamePin: widget.gamePin,
                      timer: widget.timer,
                      scorePerQuestion: widget.scorePerQuestion)));
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        leading: Container(
          width: 10,
          height: 10,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 5),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.purple),
          child: Text(
            "$start",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        leadingWidth: 70,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          _save();
                          choice = "A";
                          var res = await userSubmitAnswerAPI(
                              box.read("playerResultID"),
                              widget.questionIndex + 1,
                              choice,
                              widget.quizId);
                          if (res.statusCode == 200) {
                            print(res.data);
                            box.write("message_result", res.data["message"]);
                            print(box.read("message_result"));
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InitialScreen()));
                        },
                        child: Container(
                          color: Colors.red,
                          height: MediaQuery.of(context).size.height * 0.42,
                          child: Image.asset(
                            "assets/images/img_player_3.png",
                            scale: 1.6,
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          _save();
                          choice = "B";
                          var res = await userSubmitAnswerAPI(
                              box.read("playerResultID"),
                              widget.questionIndex + 1,
                              choice,
                              widget.quizId);
                          if (res.statusCode == 200) {
                            print(res.data);
                            box.write("message_result", res.data["message"]);
                            print(box.read("message_result"));
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InitialScreen()));
                        },
                        child: Container(
                          color: Colors.blue,
                          height: MediaQuery.of(context).size.height * 0.42,
                          child: Image.asset(
                            "assets/images/img_player_4.png",
                            scale: 1.6,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          _save();
                          choice = "C";
                          var res = await userSubmitAnswerAPI(
                              box.read("playerResultID"),
                              widget.questionIndex + 1,
                              choice,
                              widget.quizId);
                          if (res.statusCode == 200) {
                            print(res.data);
                            box.write("message_result", res.data["message"]);
                            print(box.read("message_result"));
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InitialScreen()));
                        },
                        child: Container(
                          color: Colors.yellow[700],
                          height: MediaQuery.of(context).size.height * 0.42,
                          child: Image.asset(
                            "assets/images/img_player_1.png",
                            scale: 1.6,
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          _save();
                          choice = "D";
                          var res = await userSubmitAnswerAPI(
                              box.read("playerResultID"),
                              widget.questionIndex + 1,
                              choice,
                              widget.quizId);
                          if (res.statusCode == 200) {
                            print(res.data);
                            box.write("message_result", res.data["message"]);
                            print(box.read("message_result"));
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InitialScreen()));
                        },
                        child: Container(
                          color: Colors.green,
                          height: MediaQuery.of(context).size.height * 0.42,
                          child: Image.asset(
                            "assets/images/img_player_2.png",
                            scale: 1.6,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    if (value == 2) return;
    value = value + 1;
    //await prefs.setInt(key, value);
  }
}
