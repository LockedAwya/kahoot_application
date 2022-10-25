import 'package:flutter/material.dart';
import '../utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../NotLoggedIn/no_auth.dart';
import '../router.dart';
import 'create_kahoot/create_kahoot.dart';
import './components/quiz_component.dart';

class MyKahootScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  const MyKahootScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyKahootScreen> createState() => _MyKahootScreen();
}

class _MyKahootScreen extends State<MyKahootScreen> {
  final double borderWidth = 0.5;
  final double containerHeight = 65;
  final double fontSize = 24;
  String? username = "";
  bool token = false;
  List<Widget> quizList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (prefs.containsKey('username')) {
        username = prefs.getString('username');
      }
      if (prefs.containsKey('token')) {
        //token = prefs.getString('token');
        token = true;
      }
      //username = shared_preferences.stringGetter('username')!;
      // quizList.addAll([
      //   QuizComponent("Something", "Something", "duc"),
      //   SizedBox(height: 5),
      //   QuizComponent("Something", "Something", "duc"),
      //   SizedBox(height: 5),
      //   QuizComponent("Something", "Something", "duc"),
      //   SizedBox(height: 5),
      //   QuizComponent("Something", "Something", "duc"),
      //   SizedBox(height: 5),
      // ]);
      //quizList = widget.quizList;
      quizList = quizListGlobal;
    });
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
                padding: EdgeInsets.zero,
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
        actions: [
          IconButton(
            alignment: Alignment.center,
            iconSize: 40,
            icon: const Text(
              "Create kahoot",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              quizListGlobal = quizList;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateKahoot()));
            },
          ),
        ],
      ),
      body: token
          ? SafeArea(
              child: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              children: quizList,
            ))
          : (SafeArea(child: NoAuth())),
    );
  }
}
