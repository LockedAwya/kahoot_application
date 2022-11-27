import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math' as math;
import '../../api/index.dart';
import '../score_board.dart';
import '../../utils/global_variables.dart';

class HostScreen extends StatefulWidget {
  final int questionIndex;
  const HostScreen({Key? key, required this.questionIndex}) : super(key: key);

  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  Timer? _timer;
  int start = 20;
  final key = 'point';
  int value = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _read();
    startTimer();
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    var values = prefs.getInt(key) ?? 0;
    if (value != null) {
      setState(() {
        value = values;
      });
    }
    print('read: $value');
  }

  void startTimer() {
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
                  builder: (context) =>
                      ScoreBoard(questionIndex: widget.questionIndex)));
          // else {
          //   print("Game overrrrrrrrrrr");
          // }
          //     .then((value) {
          //   if (value != null && value) {
          //     setState(() {
          //       start = 20;
          //     });
          //     startTimer();
          //   }
          // });
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
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.deepPurpleAccent,
        //   leading: Container(
        //     width: 10,
        //     height: 10,
        //     alignment: Alignment.center,
        //     child: Text(
        //       "$start",
        //       style: const TextStyle(fontSize: 16, color: Colors.white),
        //     ),
        //     margin: const EdgeInsets.only(top: 5),
        //     decoration:
        //         const BoxDecoration(shape: BoxShape.circle, color: Colors.purple),
        //   ),
        //   leadingWidth: 70,
        // ),
        body: Container(
            width: 428,
            height: 926,
            decoration: BoxDecoration(
              color: Color.fromRGBO(71, 23, 143, 1),
            ),
            child: Stack(children: <Widget>[
              Positioned(
                  top: 140,
                  left: 57,
                  child: Text(
                    "Question ${widget.questionIndex + 1}" +
                        '${box.read('questionList')[widget.questionIndex]['question']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  top: 150,
                  left: 100,
                  child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/image10.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              // Positioned(
              //   top: 22,
              //   left: 333,
              //   child: SvgPicture.asset(
              //   'assets/images/rectangle6.svg',
              //   semanticsLabel: 'rectangle6'
              // ),
              // ),
              Positioned(
                  top: 360,
                  left: 20,
                  child: Container(
                      width: 400,
                      height: 330,
                      decoration: BoxDecoration(),
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 170,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(226, 27, 60, 1),
                                ))),
                        Positioned(
                            top: 0,
                            left: 200,
                            child: Container(
                                width: 170,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(19, 103, 205, 1),
                                ))),
                        Positioned(
                            top: 170,
                            left: 0,
                            child: Container(
                                width: 170,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(216, 158, 0, 1),
                                ))),
                        Positioned(
                            top: 170,
                            left: 200,
                            child: Container(
                                width: 170,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(38, 137, 11, 1),
                                ))),
                        Positioned(
                            top: 55,
                            left: 228,
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(50, 50)),
                                ))),
                        Positioned(
                            top: 223,
                            left: 24,
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(217, 217, 217, 1),
                                ))),
                        Positioned(
                            top: 248.16458129882812,
                            left: 216,
                            child: Transform.rotate(
                              angle: 43.10138810937647 * (math.pi / 180),
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(217, 217, 217, 1),
                                  )),
                            )),
                        Positioned(
                            top: 239,
                            left: 295,
                            child: Text(
                              '${box.read('questionList')[widget.questionIndex]['answerList'][3]['body']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 10,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            )),
                        Positioned(
                            top: 70,
                            left: 284,
                            child: Text(
                              '${box.read('questionList')[widget.questionIndex]['answerList'][1]['body']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 10,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            )),
                        Positioned(
                            top: 69,
                            left: 80,
                            child: Text(
                              '${box.read('questionList')[widget.questionIndex]['answerList'][0]['body']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 10,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            )),
                        Positioned(
                            top: 231,
                            left: 80,
                            child: Text(
                              '${box.read('questionList')[widget.questionIndex]['answerList'][2]['body']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 10,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            )),
                        // Positioned(top: 51, left: 20, child: null),
                      ]))),
              Positioned(
                  top: 7,
                  left: 9,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 4)
                        ],
                        color: Color.fromRGBO(134, 76, 191, 1),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(74, 74)),
                      ))),
              Positioned(
                  top: 25,
                  left: 20,
                  child: Text(
                    '$start',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
            ])));
  }
}
