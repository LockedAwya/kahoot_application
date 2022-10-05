import 'package:flutter/material.dart';
import 'question_modal_bottom_sheet.dart';
import '../utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostGameScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<HostGameScreen> createState() => _HostGameScreen();
}

class QuestionComponent extends StatelessWidget {
  final String text1;
  const QuestionComponent({super.key, required this.text1});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //padding: EdgeInsets.all(5),
      // alignment: Alignment.topLeft,
      onTap: () {
        //print("Click ${text1}");
        showModalBottomSheet<dynamic>(
            isScrollControlled: true,
            context: context,
            // builder: (context) =>
            builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
                  ),
                ),
                child: QuestionModalBottomSheet()));
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
                    )),
                const SizedBox(height: 25), // <-- Set height
                const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text("Something")),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.only(
                      left: 0), //apply padding horizontal or vertical only
                  child: Text("Lorem"),
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
        title: Text(
          "My Kahoots",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black.withOpacity(1.0)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      ),
      body: token ? SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        children: const <Widget>[
          QuestionComponent(text1: 'lol'),
          SizedBox(height: 5),
          QuestionComponent(text1: "lol"),
          SizedBox(height: 5),
        ],
      )) : (SafeArea(child: Text("You're not logged in yet!"))),
    );
  }
}
