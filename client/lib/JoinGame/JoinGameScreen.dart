import 'package:flutter/material.dart';
import '../WaitingRoom/WaitingRoomScreen.dart';

class JoinGameScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<JoinGameScreen> createState() => _JoinGameScreen();
}

class _JoinGameScreen extends State<JoinGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: const Text(
                "Join a quiz game!",
                style: TextStyle(
                  height: 1.0,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
              child: TextField(
                //controller: text1Controller,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Game ID',
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
              child: TextField(
                //controller: text2Controller,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0)),
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
