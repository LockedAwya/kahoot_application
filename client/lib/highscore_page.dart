import 'package:flutter/material.dart';

class HighScorePage extends StatefulWidget {
  const HighScorePage({Key? key}) : super(key: key);

  @override
  _HighScorePageState createState() => _HighScorePageState();
}

class _HighScorePageState extends State<HighScorePage> {
  double max = 450;
  double medium = 300;
  double min = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text(
            "Game Over",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HighScoreItem(
                  text: 'FunnyBizon',
                  image: 'assets/icons/ic_game_2.png',
                  height: min,
                ),
                HighScoreItem(
                  text: 'SpaceHazard',
                  image: 'assets/icons/ic_game_1.png',
                  height: max,
                ),
                HighScoreItem(
                  text: 'Bronzelbex',
                  image: 'assets/icons/ic_game_3.png',
                  height: medium,
                ),
              ],
            )
          ],
        ));
  }
}

class HighScoreItem extends StatelessWidget {
  final String? text;
  final double? height;
  final String? image;
  const HighScoreItem({Key? key, this.text, this.height, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Text(
            text ?? "",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 120,
            height: height,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: height! * 0.08,
                ),
                Image.asset(
                  '$image',
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  height: height! * 0.08,
                ),
                Text(
                  "${height?.toInt()}/450",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
