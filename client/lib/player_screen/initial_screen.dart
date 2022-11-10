import 'package:flutter/material.dart';
import 'package:untitled_folder/score_board.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          InkWell(
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const ScoreBoard()));
            },
            child: Container(
              width: 60,
              height: 6,
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Text(
                "Next",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Waiting for other players...",
          style: TextStyle(color: Colors.white, fontSize: 26),
        ),
      ),
    );
  }
}
