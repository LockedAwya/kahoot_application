import 'package:flutter/material.dart';
import 'package:untitled_folder/SecretScreen/quiz/components/add_question.dart';
//import './quiz_page_body.dart';
//import '../../../utils/global_variables.dart';
//import 'package:shared_preferences/shared_preferences.dart';
// import '../../../model/question_model.dart';
// import '../../../model/answer_model.dart';
import '../quiz_details.dart';
import 'package:untitled_folder/model/quiz_model.dart';

import 'package:untitled_folder/SecretScreen/quiz/components/create_answer_4.dart';
import 'package:untitled_folder/SecretScreen/quiz/components/create_answer_1.dart';
import 'package:untitled_folder/SecretScreen/quiz/components/create_answer_2.dart';
import 'package:untitled_folder/SecretScreen/quiz/components/create_answer_3.dart';
import '../../../utils/global_variables.dart';
import '../create_kahoot.dart';

class QuizPage extends StatefulWidget {
  final List<QuestionModel> listValue;
  final int currentIndexPage;
  //final List<dynamic> cacheListValue;
  const QuizPage({
    Key? key,
    required this.listValue,
    required this.currentIndexPage,
    //required this.cacheListValue
  }) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

//initial();
class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  final fieldController = TextEditingController();
  String? answer1 = 'Add answer';
  String? answer2 = 'Add answer';
  String? answer3 = 'Add answer \n(optional)';
  String? answer4 = 'Add answer \n(optional)';
  List<QuestionModel> listQuiz = [];
  TabController? tabController;
  int currentpage = 0;
  @override
  void initState() {
    super.initState();
    //listQuiz = widget.listValue;
    if (box.hasData("listOfQuestionsCache")) {
      //listQuiz = widget.listValue;
      if (globalState == "create-quiz-add-quiz") {
        listQuiz = widget.listValue;
      } else {
        listQuiz = [];
        for (int i = 0; i < box.read("listOfQuestionsCache").length; i++) {
          listQuiz
              .add(QuestionModel.fromJson(box.read("listOfQuestionsCache")[i]));
        }
      }
    } else {
      listQuiz = widget.listValue;
    }
    globalState = "create-quiz";
    currentpage = widget.currentIndexPage;
    tabController =
        TabController(initialIndex: 0, length: listQuiz.length, vsync: this);
    //print(box.read("quiz_details")["questionList"]);
    tabController?.animateTo(currentpage);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: const Color(0xFFfafafa),
          appBar: AppBar(
            elevation: 1.2,
            //titleSpacing: 20,
            leadingWidth: 70,
            backgroundColor: Colors.white,
            title: Material(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {},
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/img_0.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Quiz",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              alignment: Alignment.center,
              iconSize: 20,
              icon: Padding(
                padding: EdgeInsets.zero,
                child: Image.asset(
                  'assets/icons/ic_drop.png',
                  width: 20,
                  height: 20,
                ),
              ),
              onPressed: () {
                print("PIP");
                goBackToQuiz();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => QuizDetails(
                //           box.read("quiz_details")["id"],
                //           box.read("quiz_details")["title"],
                //           box.read("quiz_details")["description"])),
                // );
                //Navigator.of(context).pop();
                // if (box.hasData("quiz_details")) {
                //   box.remove("quiz_details");
                // }
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => QuizDetails()));
              },
            ),
            actions: [
              IconButton(
                alignment: Alignment.center,
                iconSize: 20,
                icon: Image.asset(
                  'assets/images/trashimg.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  print("Tap delete a question index ${currentpage}");
                  _showDeleteQuestionWarning(currentpage);
                },
              ),
            ],
          ),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              listQuiz.length != 0
                  ? Expanded(
                      //bottom
                      child: TabBarView(
                        controller: tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ...listQuiz.map((e) {
                            //fieldController.text = e.text ?? "";
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: ListTile(
                                      onTap: () {
                                        print("Tap select image");
                                      },
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                      horizontalTitleGap: 1.0,
                                      title: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          height: 190,
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Image.asset(
                                                  'assets/icons/ic_pick.png',
                                                  fit: BoxFit.cover),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                child: const Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Text(
                                                "Add Media",
                                                style: TextStyle(
                                                    color: Color(0xFF6B6B6B),
                                                    fontSize: 16),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Material(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(40),
                                      child: InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(40),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 80,
                                          height: 30,
                                          child: const Text(
                                            '20 sec',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        print("asdfasdf:$value");
                                        setState(() {
                                          listQuiz[listQuiz.indexOf(e)].text =
                                              fieldController.text;
                                        });
                                      },
                                      controller: fieldController,
                                      textInputAction: TextInputAction.done,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFF6B6B6B)),
                                        hintText: "Tap to add question",
                                        filled: true,
                                        contentPadding: EdgeInsets.all(20),
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.5,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 0.5,
                                          ),
                                        ),
                                        errorBorder: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //choice 1
                                        ButtonItem(
                                            onTap: () async {
                                              final QuestionModel value =
                                                  await Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  CreateAnswer1(
                                                                    isCorrect: listQuiz[
                                                                            listQuiz.indexOf(e)]
                                                                        .isCorrect,
                                                                    textanswer:
                                                                        listQuiz[listQuiz.indexOf(e)]
                                                                            .answer1,
                                                                  )));
                                              listQuiz[listQuiz.indexOf(e)]
                                                  .isCorrect = value.isCorrect;
                                              if (value.text?.isEmpty ?? false)
                                                return;
                                              if (value.text?.isNotEmpty ??
                                                  false) {
                                                setState(() {
                                                  listQuiz[listQuiz.indexOf(e)]
                                                      .answer1 = value.text;
                                                });
                                              }
                                            },
                                            colors: Colors.red[500],
                                            text: listQuiz[listQuiz.indexOf(e)]
                                                    .answer1 ??
                                                'Add answer',
                                            isCorrect:
                                                listQuiz[listQuiz.indexOf(e)]
                                                    .isCorrect),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        //choice 2
                                        ButtonItem(
                                          onTap: () async {
                                            final QuestionModel value =
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                CreateAnswer2(
                                                                  isCorrect: listQuiz[
                                                                          listQuiz
                                                                              .indexOf(e)]
                                                                      .isCorrect2,
                                                                  textanswer: listQuiz[
                                                                          listQuiz
                                                                              .indexOf(e)]
                                                                      .answer2,
                                                                )));
                                            listQuiz[listQuiz.indexOf(e)]
                                                .isCorrect2 = value.isCorrect;
                                            if (value.text?.isEmpty ?? false)
                                              return;
                                            if (value.text?.isNotEmpty ??
                                                false) {
                                              setState(() {
                                                listQuiz[listQuiz.indexOf(e)]
                                                    .answer2 = value.text;
                                              });
                                            }
                                          },
                                          colors: Colors.lightBlue[900],
                                          text: listQuiz[listQuiz.indexOf(e)]
                                                  .answer2 ??
                                              'Add answer',
                                          isCorrect:
                                              listQuiz[listQuiz.indexOf(e)]
                                                  .isCorrect2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  //choice 3
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ButtonItem(
                                          onTap: () async {
                                            final QuestionModel value =
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                CreateAnswer3(
                                                                  isCorrect: listQuiz[
                                                                          listQuiz
                                                                              .indexOf(e)]
                                                                      .isCorrect3,
                                                                  textanswer: listQuiz[
                                                                          listQuiz
                                                                              .indexOf(e)]
                                                                      .answer3,
                                                                )));
                                            listQuiz[listQuiz.indexOf(e)]
                                                .isCorrect3 = value.isCorrect;
                                            if (value.text?.isEmpty ?? false)
                                              return;
                                            if (value.text?.isNotEmpty ??
                                                false) {
                                              setState(() {
                                                listQuiz[listQuiz.indexOf(e)]
                                                    .answer3 = value.text;
                                              });
                                            }
                                          },
                                          colors: Colors.yellow[800],
                                          text: listQuiz[listQuiz.indexOf(e)]
                                                  .answer3 ??
                                              'Add answer\n(optional)',
                                          isCorrect:
                                              listQuiz[listQuiz.indexOf(e)]
                                                  .isCorrect3,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        //choice 4
                                        ButtonItem(
                                          onTap: () async {
                                            final QuestionModel value =
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                CreateAnswer4(
                                                                  isCorrect: listQuiz[
                                                                          listQuiz
                                                                              .indexOf(e)]
                                                                      .isCorrect4,
                                                                  textanswer: listQuiz[
                                                                          listQuiz
                                                                              .indexOf(e)]
                                                                      .answer4,
                                                                )));
                                            listQuiz[listQuiz.indexOf(e)]
                                                .isCorrect4 = value.isCorrect;
                                            if (value.text?.isEmpty ?? false)
                                              return;
                                            if (value.text?.isNotEmpty ??
                                                false) {
                                              setState(() {
                                                listQuiz[listQuiz.indexOf(e)]
                                                    .answer4 = value.text;
                                              });
                                            }
                                          },
                                          colors: Colors.green[900],
                                          text: listQuiz[listQuiz.indexOf(e)]
                                                  .answer4 ??
                                              'Add answer\n(optional)',
                                          isCorrect:
                                              listQuiz[listQuiz.indexOf(e)]
                                                  .isCorrect4,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    )
                  : (Expanded(
                      child: Center(
                          child: Text(
                      "Click the + below to add a question!",
                      style: const TextStyle(fontSize: 20),
                    )))),
              const Divider(
                thickness: 0.5,
                color: Colors.black12,
              ),
              //bottom of the page including a list of white rectangle of questions
              Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(bottom: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          controller: tabController,
                          isScrollable: true,
                          labelPadding: const EdgeInsets.only(right: 5),
                          indicatorColor: Colors.white,
                          onTap: (page) {
                            setState(() {
                              currentpage = page;
                              print("Current page: ${currentpage}");
                            });
                            fieldController.text =
                                listQuiz[currentpage].text ?? "";
                            tabController?.animateTo(page);
                          },
                          //white box list
                          tabs: [
                            ...listQuiz.map((e) {
                              int index = listQuiz.indexOf(e);
                              return Container(
                                width: 100,
                                height: 60,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: currentpage == index
                                            ? Colors.blueAccent
                                            : Colors.black12,
                                        width: 2)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      listQuiz[index].text ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 10),
                                    )
                                  ],
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.0),
                          onTap: () {
                            //listQuiz = widget.listValue;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddQuestion(
                                      listValue: listQuiz,
                                    )));
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  void goBackToQuiz() {
    List<dynamic> temp = [];
    for (int i = 0; i < listQuiz.length; ++i) {
      // print(listQuiz[i].text);
      // print(listQuiz[i].answer1);
      temp.add({
        "backgroundQuestion": listQuiz[i].backgroundQuestion,
        "question": listQuiz[i].text,
        "answerList": [
          {
            "name": "A",
            "body": listQuiz[i].answer1,
            "isCorrect": listQuiz[i].isCorrect
          },
          {
            "name": "B",
            "body": listQuiz[i].answer2,
            "isCorrect": listQuiz[i].isCorrect2
          },
          {
            "name": "C",
            "body": listQuiz[i].answer3,
            "isCorrect": listQuiz[i].isCorrect3
          },
          {
            "name": "D",
            "body": listQuiz[i].answer4,
            "isCorrect": listQuiz[i].isCorrect4
          },
        ],
        "questionIndex": (i + 1),
      });
    }
    box.write("listOfQuestionsCache", temp);
    print(box.read("listOfQuestionsCache"));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateKahoot()),
    );
  }

  Future<void> _showDeleteQuestionWarning(int questionIndex) {
    return showDialog<void>(
        context: context,
        //barrierDismissible: false, // user must tap button!
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete question'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('You are going to delete the question.'),
                  Text('Are you sure to do that?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    print(questionIndex);
                    // if (currentpage != 0) {
                    int previousQuizLength = listQuiz.length;
                    listQuiz.removeAt(currentpage);
                    int currentListQuizLength = listQuiz.length;
                    print(listQuiz.length);
                    setState(() {
                      if (currentpage != currentListQuizLength - 1 &&
                          currentpage != previousQuizLength - 1) {
                        tabController = TabController(
                            initialIndex: currentpage + 1,
                            length: currentListQuizLength,
                            vsync: this);
                      } else if (currentpage == previousQuizLength - 1) {
                        if (currentListQuizLength == 0) {
                          tabController = TabController(
                              initialIndex: 0,
                              length: currentListQuizLength,
                              vsync: this);
                          // tabController = TabController(
                          //   initialIndex: 0,
                          //   length: listQuiz.length,
                          //   vsync: this);
                        } else {
                          tabController = TabController(
                              initialIndex: currentpage - 1,
                              length: currentListQuizLength,
                              vsync: this);
                        }
                      }
                      //tabController?.animateTo(currentpage);
                    });
                    Navigator.of(context).pop();
                  }
                  // },
                  ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want go back to quiz page?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false), //<-- SEE HERE
                  child: new Text('No'),
                ),
                TextButton(
                  onPressed: () => goBackToQuiz(), // <-- SEE HERE
                  child: new Text('Yes'),
                ),
              ],
            )));
  }

  Widget textField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: fieldController,
          textInputAction: TextInputAction.done,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0xFF6B6B6B)),
            hintText: "Tap to add question",
            filled: true,
            contentPadding: EdgeInsets.all(20),
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
                width: 0.5,
              ),
            ),
            errorBorder: null,
          ),
        ),
      );
}

class ButtonItem extends StatelessWidget {
  final Color? colors;
  final String text;
  final VoidCallback? onTap;
  final bool isCorrect;
  const ButtonItem(
      {Key? key,
      required this.colors,
      required this.text,
      this.onTap,
      required this.isCorrect})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5.0),
      color: colors,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.43,
          height: 60,
          child: Stack(
            //  alignment: Alignment,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),
              Visibility(
                visible: isCorrect,
                child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          'assets/icons/ic_tick.png',
                          width: 20,
                          height: 20,
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
