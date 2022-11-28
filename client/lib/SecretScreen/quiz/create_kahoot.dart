import 'package:flutter/material.dart';
//import 'package:untitled_folder/SecretScreen/quiz/components/add_question.dart';
import 'package:untitled_folder/SecretScreen/quiz/components/quiz_page.dart';
import '../../utils/widget.dart';
import 'my_kahoots.dart';
//import 'components/quiz_component.dart';
import '../../utils/global_variables.dart';
import '../../api/index.dart';
import '../../model/quiz_model.dart';
import './components/question_component.dart';

class CreateKahoot extends StatefulWidget {
  //final List<Widget> quizList;

  const CreateKahoot({Key? key}) : super(key: key);
  //const CreateKahoot({required this.quizList});

  @override
  _CreateKahootState createState() => _CreateKahootState();
}

class _CreateKahootState extends State<CreateKahoot> {
  late TextEditingController quizTitleController;
  late TextEditingController quizDescriptionController;
  List<QuestionModel> quizModelList = [];
  int numberOfQuestions = 0;

  late int initialTime;
  late int initialScore;

  // List of items in our dropdown menu
  var timePerQuestion_items = [
    5,
    10,
    20,
    30,
    40,
  ];

  var scorePerQuestion_items = [
    10,
    20,
    30,
    40,
    50,
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (box.hasData("quiz_cache")) {
      quizTitleController =
          TextEditingController(text: box.read("quiz_cache")["name"]);
      quizDescriptionController = TextEditingController(
          text: box.read("quiz_cache")["description"]);
      initialTime = box.read("quiz_cache")["timer"];
      initialScore = box.read("quiz_cache")["scorePerQuestion"];
      // "scorePerQuestion": initialScore,
      //                       "timer": initialTime
    } else {
      quizTitleController = TextEditingController(text: "");
      quizDescriptionController = TextEditingController(text: "");
      initialTime = 20;
      initialScore = 10;
    }
    if (box.hasData("listOfQuestionsCache")) {
      print(box.read("listOfQuestionsCache"));
      numberOfQuestions = box.read("listOfQuestionsCache").length;
    } else {
      print("Question list does not exist!!");
    }
  }

  void saveQuizFunc(
      String name,
      String description,
      String background,
      String creatorId,
      String creatorName,
      int scorePerQuestion,
      int timer,
      int numberOfQuestion,
      List questionList,
      BuildContext context) async {
    var res = await addQuizAPI(name, description, background, creatorId,
        creatorName, scorePerQuestion, timer, numberOfQuestion, questionList);
    if (res.statusCode == 200) {
      Quiz quiz = Quiz.fromJson(res.data);
      print(quiz.name);
      if (!mounted) return;
      // box.remove("listOfQuestionsCache");
      // box.remove("")
      box.erase();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyKahootScreen()));
    } else {
      print(res.statusCode);
      print(res.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        elevation: 1.2,
        titleSpacing: 20,
        leadingWidth: 70,
        backgroundColor: Colors.white,
        title: ListTile(
          onTap: () {
            print("Tap create Kahoot");
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  "Create Kahoot",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: const Divider(
                  color: Color(0xFFF4F4F4),
                  thickness: 6,
                ),
              )
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          alignment: Alignment.center,
          iconSize: 30,
          icon: const Text(
            "Cancel",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            print("Tap cancel");
            box.erase();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyKahootScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            alignment: Alignment.center,
            iconSize: 36,
            icon: const Text(
              "Save",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 8, 8, 8),
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              print("Tap Save");
              saveQuizFunc(
                  quizTitleController.text,
                  quizTitleController.text,
                  "" /**background */,
                  userId,
                  username,
                  initialScore /** */,
                  initialTime /**timer */,
                  box
                      .read("listOfQuestionsCache")
                      .length /**number of question */,
                  box.read("listOfQuestionsCache") /**question list */,
                  context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListTile(
                tileColor: Colors.white,
                onTap: () {
                  print("Tap select image");
                },
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                horizontalTitleGap: 1.0,
                title: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Image.asset("assets/icons/ic_pic.png"),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Add cover Image",
                        style:
                            TextStyle(color: Color(0xFF6B6B6B), fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Title",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            textField(),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Description",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            textField1(),
            const SizedBox(
              height: 10,
            ),
            timedropdown(),
            const SizedBox(
              height: 10,
            ),
            scoredropdown(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Questions (" + numberOfQuestions.toString() + ")",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              //children: (box.read("questionsList") as List).map((item) => new Text(item).toList()),
              //     List.generate(snapshot.data!.questionList.length, (index) {
              //   return Text(
              //     snapshot.data!.questionList[index].toString(),
              //     style: const TextStyle(fontSize: 22),
              //   );
              // }),
              children: box.hasData("listOfQuestionsCache") == true
                  ? <Widget>[
                      // (box.read("questionsList") as List)
                      //     .map((item) => new Text(item))
                      //     .toList()
                      for (var question in box.read("listOfQuestionsCache"))
                        //   Text(question.toString())
                        Column(
                          children: [
                            QuestionComponent(
                                // box.read(
                                // "quiz_details")["questionList"]
                                // snapshot.data!.questionList[index]
                                //     ["backgroundQuestion"],
                                "",
                                question["question"],
                                question["questionIndex"]),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                    ]
                  : <Widget>[],
            ),
            Stack(children: [
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  //top: 200,
                  // left: 500,
                  // right: 100,
                  padding: EdgeInsets.only(
                    left: 0.0,
                    top: 50,
                    right: 5,
                    bottom: 0,
                  ),
                  child: Positioned(
                      top: 200,
                      child: AppButton(
                        width: 150,
                        height: 50,
                        text: 'Add Question',
                        onTap: () {
                          box.write("quiz_cache", {
                            "name": quizTitleController.text,
                            "description": quizDescriptionController.text,
                            "scorePerQuestion": initialScore,
                            "timer": initialTime
                          });
                          // box.write("quiz-name", quizTitleController.text);
                          // box.write("quiz-description",
                          //     quizDescriptionController.text);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QuizPage(
                                    listValue: quizModelList,
                                    currentIndexPage: 0,
                                    // cacheListValue: box.hasData("listOfQuestionsCache")
                                    //     ? box.read("listOfQuestionsCache")
                                    //     : [] //todo
                                  )));
                        },
                      )),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget timedropdown() => //dropdown
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Time per question"),
          DropdownButton(
            // Initial Value
            value: initialTime,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: timePerQuestion_items.map((int time) {
              return DropdownMenuItem(
                value: time,
                child: Text(time.toString()),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (int? newValue) {
              setState(() {
                initialTime = newValue!;
                print(initialTime);
              });
            },
            onTap: () {
              setState(() {
                print(initialTime);
              });
            },
          ),
        ],
      );

  Widget scoredropdown() => //dropdown
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Score per question"),
          DropdownButton(
            // Initial Value
            value: initialScore,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: scorePerQuestion_items.map((int score) {
              return DropdownMenuItem(
                value: score,
                child: Text(score.toString()),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (int? newValue) {
              setState(() {
                initialScore = newValue!;
                print(initialScore);
              });
            },
            onTap: () {
              setState(() {
                print(initialScore);
              });
            },
          ),
        ],
      );

  Widget textField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: TextFormField(
              controller: quizTitleController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5E5E5E)),
                hintText: "Enter title",
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                errorBorder: null,
              ),
            )),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 58,
              height: 58,
              alignment: Alignment.center,
              // margin: EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Image.asset(
                "assets/icons/ic_settings.png",
                scale: 1.6,
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 10),
            //   child: Text(
            //     "Description",
            //     style: TextStyle(
            //         fontSize: 16,
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            //textField1(quizDescriptionController.text),
          ],
        ),
      );

  Widget textField1() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: TextFormField(
              controller: quizDescriptionController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5E5E5E)),
                hintText: "Enter description",
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                errorBorder: null,
              ),
            )),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      );

  @override
  void dispose() {
    //super.dispose();
    quizTitleController.dispose();
    super.dispose();
  }
}
