import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './highscore_page.dart';
import 'package:untitled_folder/model/score_board_model.dart';
import 'package:untitled_folder/GamePlay/player_screen/player_screen.dart';
import '../../utils/global_variables.dart';
import './host_screen/host_screen.dart';

class ScoreBoard extends StatefulWidget {
  final int questionIndex;
  const ScoreBoard({Key? key, required this.questionIndex}) : super(key: key);

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  List<ScoreBoardModel> listScore = [
    ScoreBoardModel(namePlay: 'Player1', score: '897'),
    ScoreBoardModel(namePlay: 'LockedAway00', score: '855', me: true),
    ScoreBoardModel(namePlay: 'Player2', score: '810'),
    ScoreBoardModel(namePlay: 'Player4', score: '0'),
    ScoreBoardModel(
      namePlay: 'Player3',
      score: '0',
    )
  ];
  int countClick = 0;

  @override
  void initState() {
    // TODO: implement initState
    print("question index is");
    print(widget.questionIndex);
    super.initState();
    _read();
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    var values = prefs.getInt("point") ?? 0;
    if (values != null) {
      setState(() {
        countClick = values;
      });
    }
    print('read: $values');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leadingWidth: 140,
        backgroundColor: Colors.deepPurpleAccent,
        leading: const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Scoreboard",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )),
        actions: [
          InkWell(
            onTap: () {
              if (widget.questionIndex + 1 == box.read('questionList').length) {
                countClick = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HighScorePage()));
                //return;
              } else {
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => const PlayerScreen()),
                //     (route) => false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HostScreen(
                            questionIndex: widget.questionIndex + 1)));
              }
            },
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.center,
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: const Text("Quiz game",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black))),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
            itemCount: listScore.length,
            itemBuilder: (context, index) {
              final item = listScore[index];
              return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 40,
                  color: item.me == true ? Colors.white : Colors.transparent,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "$index",
                          style: TextStyle(
                              color:
                                  item.me == true ? Colors.black : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          item.namePlay ?? "",
                          style: TextStyle(
                              color:
                                  item.me == true ? Colors.black : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item.score ?? "",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color:
                                item.me == true ? Colors.black : Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ));
            }),
      ),
    );
  }
}
