import 'package:flutter/material.dart';
// import '../utils/global_variables.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NoAuth extends StatelessWidget {
  //final String text1;
  //const QuestionComponent({super.key, required this.text1});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //padding: EdgeInsets.all(5),
      // alignment: Alignment.topLeft,
      body: SafeArea(
        child: Text("You're not logged in yet!")
      )
    );
  }
}
