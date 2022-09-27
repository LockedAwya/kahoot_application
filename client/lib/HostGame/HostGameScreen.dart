import 'package:flutter/material.dart';

class HostGameScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<HostGameScreen> createState() => _HostGameScreen();
}

class _HostGameScreen extends State<HostGameScreen> {
  final double borderWidth = 0.5;
  final double containerHeight = 65;
  final double fontSize = 24;

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
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            // alignment: Alignment.topLeft,
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/img1.jpg',
                  height: 100,
                  width: 100,
                ),
                Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topRight,
                        child: Text("Something")),
                    Text("Something"),
                    Text("LockedAway00")
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), //BorderRadius.all
            ),
          ),
          SizedBox(height: 5), // <-- Set height
        ],
      )),
    );
  }
}
