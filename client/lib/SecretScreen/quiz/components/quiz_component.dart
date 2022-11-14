import 'package:flutter/material.dart';
import '../../../GamePlay/HostGame/question_modal_bottom_sheet.dart';
import '../quiz_details.dart';
import '../../../utils/global_variables.dart';

class QuizComponent extends StatelessWidget {
  //final String text1;
  final String quizId;
  final String quizName;
  final String quizDescription;
  final String quizCreator;
  const QuizComponent(
      this.quizId, this.quizName, this.quizDescription, this.quizCreator);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //padding: EdgeInsets.all(5),
      // alignment: Alignment.topLeft,
      onTap: (() {
        if (globalState == "host_game_screen") {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => QuestionModalBottomSheet()));
          showModalBottomSheet<dynamic>(
              isScrollControlled: true,
              context: context,
              builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  child: QuestionModalBottomSheet(quizId: quizId)));
            print("Quiz id in host is: " + quizId);
        }
        if (globalState == "my_kahoots") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  QuizDetails(quizId, quizName, quizDescription)));
          print("Quiz id is: " + quizId);
        }
      }),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/img1.jpg',
            height: 100,
            width: 100,
          ),
          Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    quizName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 25), // <-- Set height
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      quizDescription,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 0),
                  //apply padding horizontal or vertical only
                  child: Text(
                    quizCreator,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ),
              ])),
        ],
      ),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey), //BorderRadius.all
      // ),
    );
  }
}
