import 'package:flutter/material.dart';
import 'question_modal_bottom_sheet.dart';
import '../../utils/global_variables.dart';
import '../../SecretScreen/NotLoggedIn/no_auth.dart';

//import '../../utils/router.dart';
//import 'create_kahoot.dart';
import '../../SecretScreen/quiz/components/quiz_component.dart';
import '../../api/index.dart';
import '../../model/quiz_model.dart';

class HostGameScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<HostGameScreen> createState() => _HostGameScreen();
}

// class QuestionComponent extends StatelessWidget {
//   //final String text1;
//   const QuestionComponent({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       //padding: EdgeInsets.all(5),
//       // alignment: Alignment.topLeft,
//       onTap: () {
//         //print("Click ${text1}");
//         showModalBottomSheet<dynamic>(
//             isScrollControlled: true,
//             context: context,
//             // builder: (context) =>
//             builder: (context) => Container(
//                 height: MediaQuery.of(context).size.height * 0.90,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: const Radius.circular(25.0),
//                     topRight: const Radius.circular(25.0),
//                   ),
//                 ),
//                 child: QuestionModalBottomSheet()));
//       },
//       child: Row(
//         children: <Widget>[
//           Image.asset(
//             'assets/images/img1.jpg',
//             height: 100,
//             width: 100,
//           ),
//           Container(
//               padding: const EdgeInsets.only(left: 10),
//               child: Column(children: <Widget>[
//                 Container(
//                   alignment: Alignment.topLeft,
//                   child: const Text(
//                     "Something",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Colors.black),
//                   ),
//                 ),
//                 const SizedBox(height: 25), // <-- Set height
//                 Container(
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.only(left: 0),
//                     child: Text(
//                       "Something",
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                     )),
//                 const SizedBox(height: 25),
//                 Container(
//                   padding: EdgeInsets.only(left: 0),
//                   //apply padding horizontal or vertical only
//                   child: Text(
//                     "LockedAway00",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                         color: Colors.grey),
//                   ),
//                 ),
//               ])),
//         ],
//       ),
//       // decoration: BoxDecoration(
//       //   border: Border.all(color: Colors.grey), //BorderRadius.all
//       // ),
//     );
//   }
// }

class _HostGameScreen extends State<HostGameScreen> {
  final double borderWidth = 0.5;
  final double containerHeight = 65;
  final double fontSize = 24;
  String? username = "";
  bool token = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() {
    globalState = "host_game_screen";
    print(globalState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.2,
        titleSpacing: 20,
        leadingWidth: 70,
        backgroundColor: Colors.white,
        title: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 50.5),
                child: Text(
                  "My kahoots",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     alignment: Alignment.center,
        //     iconSize: 40,
        //     icon: const Text(
        //       "Create kahoot",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //           fontSize: 10,
        //           color: Colors.black,
        //           fontWeight: FontWeight.bold),
        //     ),
        //     onPressed: () {
        //       //quizListGlobal = quizList;
        //       // Navigator.push(context,
        //       //     MaterialPageRoute(builder: (context) => CreateKahoot()));
        //     },
        //   ),
        // ],
      ),
      body: isAuth == true
          ? SafeArea(
              child: FutureBuilder<List<Quiz>>(
                future: getQuizesByHostId(userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Quiz> quizList = snapshot.data as List<Quiz>;
                    return ListView.builder(
                        itemCount: quizList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(1),
                            padding: EdgeInsets.all(5),
                            color: Colors.white,
                            child: Column(
                              children: [
                                QuizComponent(
                                    quizList[index].id,
                                    quizList[index].name,
                                    quizList[index].description,
                                    quizList[index].creatorName,
                                    quizList[index].timer,
                                    quizList[index].scorePerQuestion),
                                // SizedBox(height: 5),
                              ],
                            ),
                          );
                        });
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error.toString());
                    return Text('error');
                  }
                  return CircularProgressIndicator();
                },
              ),
            )
          : (SafeArea(child: NoAuth())),
    );
  }
}
