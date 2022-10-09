import 'package:flutter/material.dart';
import '../utils/global_variables.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NoAuth extends StatelessWidget {
  //final String text1;
  //const QuestionComponent({super.key, required this.text1});
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    if (isAuth == true) {
      _visible = false;
    }
    return Scaffold(
        //padding: EdgeInsets.all(5),
        // alignment: Alignment.topLeft,
        // Visibility(
        //             visible: _isVisible,
        //             child: Image.asset("assets/logo.png",
        //               height: 300,
        //               fit: BoxFit.contain,
        //             ),
        //           ),
        body: Visibility(
            visible: _visible, child: Text("You're not logged in yet!")));
  }
}
