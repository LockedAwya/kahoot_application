import 'package:flutter/material.dart';
import '../WaitingRoom/waiting_room.dart';

class JoinGameScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<JoinGameScreen> createState() => _JoinGameScreen();
}

class _JoinGameScreen extends State<JoinGameScreen> {
  @override
  Widget build(BuildContext context) {
    // const double height = MediaQuery.of(context).size.height;
    // const double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[900],
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.only(bottom: 150.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
              child: Text(
                "Join a quiz game!",
                style: TextStyle(
                  height: 1.0,
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: TextField(
                //controller: text1Controller,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Game ID',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: TextField(
                //controller: text2Controller,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 370,
              // padding:
              //     const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0)),
                ),
                child: const Text(
                  "Enter",
                  style: TextStyle(
                    height: 1.0,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WaitingRoomScreen()),
                  )
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
