import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:untitled_folder/highscore_page.dart';
import 'package:untitled_folder/register_screen.dart';

import 'inittial_screen.dart';

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
        home: const SafeArea(child: HighScorePage()),
      ),
    );
  }
}
