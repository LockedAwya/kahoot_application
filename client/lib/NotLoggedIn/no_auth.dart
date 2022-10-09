import 'package:flutter/material.dart';
import '../utils/global_variables.dart';
import '../routing_names.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NoAuth extends StatelessWidget {
  //final String text1;
  //const QuestionComponent({super.key, required this.text1});
  bool _visible = true;

  Widget button(
    String title,
    VoidCallback onPressed, {
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? bg,
    Color? textColor,
    double? fontSize,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: textColor,
        backgroundColor: bg,
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(fontSize: fontSize)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isAuth == true) {
      _visible = false;
    }
    return Visibility(
        visible: _visible,
        //padding: EdgeInsets.all(5),
        // alignment: Alignment.topLeft,
        // Visibility(
        //             visible: _isVisible,
        //             child: Image.asset("assets/logo.png",
        //               height: 300,
        //               fit: BoxFit.contain,
        //             ),
        //           ),
        // appBar: AppBar(
        //   title: Text(
        //     'Profile',
        //     style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         fontSize: 24,
        //         color: Colors.black.withOpacity(1.0)),
        //   ),
        //   centerTitle: true,
        //   backgroundColor: const Color.fromARGB(255, 241, 241, 241),
        // ),
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Guest',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black.withOpacity(1.0)),
              ),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 241, 241, 241),
            ),
            body: Align(
                widthFactor: 25,
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Log in to Kahoot!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Log in or sign up to be able to play your kahoots and access them on other devices.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            button(
                              "Sign in",
                              () {
                                Navigator.pushNamed(context, LoginScreenView);
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 25.0),
                              bg: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 20,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            button(
                              "Sign up",
                              () {
                                Navigator.pushNamed(
                                    context, RegisterScreenView);
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 25.0),
                              bg: Colors.green,
                              textColor: Colors.white,
                              fontSize: 20,
                            ),
                          ])
                    ]))));
  }
}
