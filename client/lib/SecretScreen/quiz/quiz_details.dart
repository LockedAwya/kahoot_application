import 'package:flutter/material.dart';
import 'package:untitled_folder/SecretScreen/quiz/components/add_question.dart';
import '../../utils/widget.dart';
import 'my_kahoots.dart';
//import 'components/quiz_component.dart';
import '../../utils/global_variables.dart';
import '../../api/index.dart';
import '../../model/quiz_model.dart';
//import '../../api/index.dart';

class QuizDetails extends StatefulWidget {
  final String quizId;
  final String quizName;
  final String quizDescription;
  //final String quizCreator;
  const QuizDetails(this.quizId, this.quizName, this.quizDescription);
  @override
  _QuizDetailsState createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  late TextEditingController quizTitleController;
  late TextEditingController quizDescriptionController;
  //late var quizData;
  @override
  void initState() {
    // TODO: implement initState
    quizTitleController = TextEditingController(text: widget.quizName);
    quizDescriptionController =
        TextEditingController(text: widget.quizDescription);
    super.initState();
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
                    "Create Kahoo",
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
                    color: Color(0xFFE2E2E2),
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                print("Tap Save");
                var res = await updateQuizByIdAPI(widget.quizId,
                    quizTitleController.text, quizDescriptionController.text);
                print(res);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyKahootScreen()));
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
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              horizontalTitleGap: 1.0,
                              title: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 260,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          textField1(quizDescriptionController.text),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Question (0)",
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
                            children: List.generate(
                                snapshot.data!.questionList.length, (index) {
                              return Text(
                                snapshot.data!.questionList[index].toString(),
                                style: const TextStyle(fontSize: 22),
                              );
                            }),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: AppButton(
                                width: 180,
                                height: 60,
                                text: 'Add Question',
                                onTap: () {
                                  box.write("quiz_details", {
                                    "id": widget.quizId,
                                    "title": widget.quizName,
                                    "description": widget.quizDescription,
                                    "background": snapshot.data!.background,
                                    "numberOfQuestion":
                                        snapshot.data!.numberOfQuestion,
                                    "scorePerQuestion":
                                        snapshot.data!.scorePerQuestion,
                                    "questionList": snapshot.data!.questionList
                                  });

                                  //print("LOfasdfasdL");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const AddQuestion()));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                  : (const Center(
                      child: CircularProgressIndicator(),
                    ));
            }));
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
        width: 58,
        height: 58,
        alignment: Alignment.center,
        // margin: EdgeInsets.only(top: 10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Image.asset(
          "assets/icons/ic_settings.png",
          scale: 1.6,
        ),
      ));
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

  @override
  void dispose() {
    //super.dispose();
    quizTitleController.dispose();
    quizDescriptionController.dispose();
    super.dispose();
  }
}
