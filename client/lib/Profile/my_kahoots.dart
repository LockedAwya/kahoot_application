import 'package:flutter/material.dart';
import '../utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../NotLoggedIn/no_auth.dart';
import '../router.dart';
import '../create_kahoot/create_kahoot.dart';

class MyKahootScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<MyKahootScreen> createState() => _MyKahootScreen();
}

class QuestionComponent extends StatelessWidget {
  //final String text1;
  const QuestionComponent({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //padding: EdgeInsets.all(5),
      // alignment: Alignment.topLeft,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateKahoot()),
        );
      },
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
                  child: const Text(
                    "Something",
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
                      "Something",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 0),
                  //apply padding horizontal or vertical only
                  child: Text(
                    "LockedAway00",
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

class _MyKahootScreen extends State<MyKahootScreen> {
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

  void initial() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey('username')) {
        username = prefs.getString('username');
      }
      if (prefs.containsKey('token')) {
        //token = prefs.getString('token');
        token = true;
      }
      //username = shared_preferences.stringGetter('username')!;
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
              children: const <Widget>[
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
                QuestionComponent(),
                SizedBox(height: 5),
              ],
            ))
          : (SafeArea(child: NoAuth())),
    );
  }
}
