import 'package:flutter/material.dart';
import '../utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../NotLoggedIn/no_auth.dart';
import '../utils/router.dart';
import 'create_kahoot/create_kahoot.dart';
import './components/quiz_component.dart';
import '../api/index.dart';
import '../model/quiz_model.dart';
import '../quiz/components/quiz_details.dart';

class MyKahootScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  const MyKahootScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyKahootScreen> createState() => _MyKahootScreen();
}

class _MyKahootScreen extends State<MyKahootScreen> {
  final double borderWidth = 0.5;
  final double containerHeight = 65;
  final double fontSize = 24;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
    //quizListInitial();
  }

  void initial() async {
    //prefs = await SharedPreferences.getInstance();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // if (prefs.containsKey('username')) {
      //   username = prefs.getString('username');
      // }
      // if (prefs.containsKey('token')) {
      //   //token = prefs.getString('token');
      //   token = true;
      // }
      // userId = prefs.getString('userId') as String;
    });
    //fetchQuizList = await getQuizesByHostId(userId) as Future<dynamic>;
  }

  // void quizListInitial() async {
  //   var res = await getQuizesByHostId(userId);
  //   if (res.statusCode == 200) {
  //     print(res.data);
  //     //quizList = res.data;
  //     for (int i = 0; i < res.data.length; i++) {
  //       Quiz quiz = Quiz.fromJson(res.data[i]);
  //       _quizList.add(quiz);
  //     }
  //   } else {
  //     print(res.statusMessage);
  //   }
  // }

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
              //quizListGlobal = quizList;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateKahoot()));
            },
          ),
        ],
      ),
      body: isAuth == true
          ? SafeArea(
              child: FutureBuilder<List<Quiz>>(
                future: getQuizesByHostId(userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Quiz> quizList = snapshot.data as List<Quiz>;
                    return ListView.builder(
                        itemCount: quizList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            color: Colors.white,
                            child: Column(
                              children: [
                                QuizComponent(
                                    quizList[index].id,
                                    quizList[index].name,
                                    quizList[index].description,
                                    quizList[index].creatorName),
                                // SizedBox(height: 5),
                              ],
                            ),
                          );
                        });
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error.toString());
                    return Text('error');
                  }
                  return CircularProgressIndicator();
                },
              ),
            )
          : (SafeArea(child: NoAuth())),
    );
  }
}
