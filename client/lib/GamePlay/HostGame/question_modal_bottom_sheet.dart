//import '../WaitingRoom/waiting_room.dart';
import 'package:flutter/material.dart';
import '../WaitingRoom/game_pin.dart';
import '../../utils/routing_names.dart';
import '../../utils/global_variables.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class QuestionModalBottomSheet extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  final String quizId;
  // final String quizName;
  // final String quizDescription;
  // final String quizCreator;
  const QuestionModalBottomSheet({required this.quizId});
  @override
  State<QuestionModalBottomSheet> createState() => _QuestionModalBottomSheet();
}

class _QuestionModalBottomSheet extends State<QuestionModalBottomSheet> {
  late int gameId;
  late String quizId;
  //late var gameData;

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
                // gameData = {
                //   quizId: quiz._id,
                //   isLive: true,
                //   pin: String(Math.floor(Math.random() * 9000) + 1000)
                // }
                print("Lmao"),
                // gameData = {
                //   "quizId": widget.quizId,
                //   "gameId": gameId,
                // },
                gameId = random(1000000, 9999999),
                //initSocket(),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GamePin(gameData: {
                            "quizId": widget.quizId,
                            "gameId": gameId,
                          })),
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}
