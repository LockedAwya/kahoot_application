//import '../WaitingRoom/waiting_room.dart';
import 'package:flutter/material.dart';
import '../WaitingRoom/game_pin.dart';
import '../../utils/routing_names.dart';

class QuestionModalBottomSheet extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<QuestionModalBottomSheet> createState() => _QuestionModalBottomSheet();
}

class _QuestionModalBottomSheet extends State<QuestionModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0)),
              ),
              child: const Text(
                "Start",
                style: TextStyle(
                  height: 1.0,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              onPressed: () => {
                //Navigator.pushNamed(context, WaitingRoomScreenView)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePin()),
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}
