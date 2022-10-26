// import 'package:flutter/material.dart';
// //import 'SecretScreen/SecretScreen.dart';
// import './InitialScreen/inittial_screen.dart';
// import 'package:oktoast/oktoast.dart';

// void main() {
//   runApp(const MyApp());
// }

// GlobalKey<NavigatorState> globalKey = GlobalKey();

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return OKToast(
//         child: MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // Try running your application with "flutter run". You'll see the
//           // application has a blue toolbar. Then, without quitting the app, try
//           // changing the primarySwatch below to Colors.green and then invoke
//           // "hot reload" (press "r" in the console where you ran "flutter run",
//           // or simply save your changes to "hot reload" in a Flutter IDE).
//           // Notice that the counter didn't reset back to zero; the application
//           // is not restarted.
//           primaryColor: Colors.green),
//       //home: const Layout(title: "Test"),
//       home: const SafeArea(child: InittialScreen()),
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:untitled_folder/InitialScreen/initial_screen.dart';
import 'package:untitled_folder/add_question/add_question.dart';
import 'package:untitled_folder/create_kahoot/create_kahoot.dart';
import 'package:untitled_folder/highscore_page.dart';
import 'package:untitled_folder/quiz_page/create_answer_1.dart';
import 'package:untitled_folder/quiz_page/create_answer_3.dart';
import 'package:untitled_folder/quiz_page/quiz_page.dart';
import 'package:untitled_folder/score_board.dart';
import './router.dart' as router;
import './routing_names.dart';
//import './InitialScreen/register_screen.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> globalKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: globalKey,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.deepPurpleAccent),
        home: const SafeArea(child: CreateKahoot()),
        // onGenerateRoute: router.generateRoute,
        // initialRoute: InitialScreenView,
      ),
    );
  }
}
