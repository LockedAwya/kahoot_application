import 'package:flutter/material.dart';
import 'dart:math' as math;

class HostGamePlayScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<HostGamePlayScreen> createState() => _HostGamePlayScreen();
}

class _HostGamePlayScreen extends State<HostGamePlayScreen> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator QuestionhostWidget - FRAME
    return Container(
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
                'What is the capital city of Vietnam?',
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
              top: 27,
              left: 340,
              child: Text(
                'Skip',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
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
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(50, 50)),
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
                          'Da Nang',
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
                          'Hai Phong',
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
                          'Ha Noi',
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
                          'Ho Chi Minh City',
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
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4)
                    ],
                    color: Color.fromRGBO(134, 76, 191, 1),
                    borderRadius: BorderRadius.all(Radius.elliptical(74, 74)),
                  ))),
          Positioned(
              top: 25,
              left: 20,
              child: Text(
                '20',
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
        ]));
  }
}
