import 'package:flutter/material.dart';
import 'package:untitled_folder/SecretScreen/quiz/components/add_question.dart';
import '../../utils/widget.dart';
import 'my_kahoots.dart';
//import 'components/quiz_component.dart';
import '../../utils/global_variables.dart';
import '../../api/index.dart';
import '../../model/quiz_model.dart';
import './components/quiz_page_2.dart';
import './components/question_component.dart';
//import '../../api/index.dart';

class QuizDetails extends StatefulWidget {
  final String quizId;
  final String quizName;
  final String quizDescription;
  final int timerPerQuestion;
  final int scorePerQuestion;
  //final String quizCreator;
  const QuizDetails(this.quizId, this.quizName, this.quizDescription,
      this.timerPerQuestion, this.scorePerQuestion);
  @override
  _QuizDetailsState createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  late TextEditingController quizTitleController;
  late TextEditingController quizDescriptionController;
  //late var quizData;
  List<QuestionModel> quizModelList = [];
  // Initial Selected Value
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
    quizTitleController = TextEditingController(text: widget.quizName);
    quizDescriptionController =
        TextEditingController(text: widget.quizDescription);
    initialTime = widget.timerPerQuestion;
    initialScore = widget.scorePerQuestion;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                        "Kahoot Details",
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
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
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
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    print("Tap Save");
                    var res = await updateQuizByIdAPI(
                        widget.quizId,
                        quizTitleController.text,
                        quizDescriptionController.text,
                        "",
                        initialScore /**score per question */,
                        initialTime /**time per question */,
                        box.hasData("quiz_details")
                            ? box.read("quiz_details")["questionList"].length
                            : box.read("questionList").length,
                        // box.hasData("quiz_details") ? box
                        //     .read("quiz_details")["questionList"]
                        //     .length : snapshot.data!
                        //                                   .questionList[index].length /** number of questions */,
                        box.hasData("quiz_details")
                            ? box.read("quiz_details")["questionList"]
                            : box.read("questionList"));
                    print(res);
                    //box.remove("quiz_details");
                    box.erase();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyKahootScreen()));
                    //box.remove("quiz_details");
                  },
                ),
              ],
            ),
            body: FutureBuilder<Quiz>(
                future: getQuizById(widget.quizId),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? (SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  onTap: () {
                                    print("Tap select image");
                                  },
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  horizontalTitleGap: 1.0,
                                  title: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    height: 260,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.zero,
                                          child: Image.asset(
                                              "assets/icons/ic_pic.png"),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Add cover Image",
                                          style: TextStyle(
                                              color: Color(0xFF6B6B6B),
                                              fontSize: 16),
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
                              textField2(quizTitleController.text),
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
                              textField1(quizDescriptionController.text),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Time per question",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              timedropdown(),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Score per question",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
                                  "Questions (" +
                                      snapshot.data!.questionList.length
                                          .toString() +
                                      ")",
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
                                children: box.hasData("quiz_details") == false
                                    ? List.generate(
                                        snapshot.data!.questionList.length,
                                        (index) {
                                        print(
                                            snapshot.data!.questionList[index]);
                                        return Container(
                                          margin: EdgeInsets.all(2),
                                          padding: EdgeInsets.all(2),
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              QuestionComponent(
                                                  // box.read(
                                                  // "quiz_details")["questionList"]
                                                  // snapshot.data!.questionList[index]
                                                  //     ["backgroundQuestion"],
                                                  "",
                                                  snapshot.data!
                                                          .questionList[index]
                                                      ["question"],
                                                  snapshot.data!
                                                          .questionList[index]
                                                      ["questionIndex"]),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                    : <Widget>[
                                        for (var question in box.read(
                                            "quiz_details")["questionList"])
                                          //Text(question.toString())

                                          Container(
                                              child: QuestionComponent(
                                                  // box.read(
                                                  // "quiz_details")["questionList"]
                                                  question[
                                                      "backgroundQuestion"],
                                                  question["question"],
                                                  question["questionIndex"])),
                                      ],
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
                                      top: 30,
                                      right: 5,
                                      bottom: 0,
                                    ),
                                    child: Positioned(
                                        top: 200,
                                        child: AppButton(
                                          width: 150,
                                          height: 50,
                                          text: 'View Questions',
                                          onTap: () {
                                            //if (!box.hasData("quiz_details")) {
                                            box.write("quiz_details", {
                                              "id": widget.quizId,
                                              "name": quizTitleController.text,
                                              "description":
                                                  quizDescriptionController
                                                      .text,
                                              "background":
                                                  snapshot.data!.background ??
                                                      "",
                                              "numberOfQuestion": snapshot
                                                  .data!.numberOfQuestion,
                                              "questionList":
                                                  snapshot.data!.questionList,
                                              "timer": initialTime,
                                              "scorePerQuestion": initialScore,
                                            });
                                            //}
                                            //print("LOfasdfasdL");
                                            List<dynamic> questionList =
                                                box.read("quiz_details")[
                                                    "questionList"];
                                            print(box.read("quiz_details"));
                                            print(questionList);
                                            setState(() {
                                              // value = widget.listValue ?? [];
                                              // value.add(QuizModel());
                                              if (questionList.length != 0) {
                                                for (int i = 0;
                                                    i < questionList.length;
                                                    i++) {
                                                  quizModelList.add(
                                                      QuestionModel.fromJson(
                                                          questionList[i]));
                                                }
                                              }
                                            });
                                            globalState = "update-quiz";
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizPage2(
                                                          listValue:
                                                              quizModelList,
                                                          currentIndexPage: 0,
                                                        )));
                                          },
                                        )),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ))
                      : (const Center(
                          child: CircularProgressIndicator(),
                        ));
                })));
  }

  Widget textField1(String text) => Padding(
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
          ],
        ),
      );
  Widget textField2(String text) => Padding(
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
            deleteButton(),
          ],
        ),
      );
  Widget deleteButton() => InkWell(
      onTap: () async {
        await _showDeleteWarning();
        print("Tapped on Delete button");
        //Navigator.pop(context);
      },
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.bottomCenter,
        // margin: EdgeInsets.only(top: 10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Image.asset(
          "assets/images/trashimg.png",
          scale: 1.4,
        ),
      ));

  Widget timedropdown() => //dropdown
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Text("Time per question"),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: DropdownButton(
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
          ),
        ],
      );

  Widget scoredropdown() => //dropdown
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Text("Score per question"),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: DropdownButton(
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
          ),
        ],
      );

  Future<void> _showDeleteWarning() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete quiz'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You are going to delete the quiz.'),
                Text('Are you sure to do that?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                print(widget.quizId);
                var res = await deleteQuizByIdAPI(widget.quizId);
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => MyKahootScreen()));
                if (res.statusCode == 200) {
                  print("Quiz has deleted successfully");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyKahootScreen()));
                } else {
                  print("NO");
                }
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want go back to my kahoots page?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //<-- SEE HERE
                  child: new Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyKahootScreen())),
                  // <-- SEE HERE
                  child: new Text('Yes'),
                ),
              ],
            )));
  }

  @override
  void dispose() {
    //super.dispose();
    quizTitleController.dispose();
    quizDescriptionController.dispose();
    super.dispose();
  }
}
