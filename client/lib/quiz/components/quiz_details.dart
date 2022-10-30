import 'package:flutter/material.dart';
import 'package:untitled_folder/add_question/add_question.dart';
import '../../utils/widget.dart';
import '../my_kahoots.dart';
import '../components/quiz_component.dart';
import '../../utils/global_variables.dart';
import '../../api/index.dart';
import '../../model/quiz_model.dart';
import '../../Profile/List_View_Screen.dart';

class QuizDetails extends StatefulWidget {
  //final List<Widget> quizList;
  //const QuizDetails({Key? key}) : super(key: key);
  //const CreateKahoot({required this.quizList});
  final String quizId;
  // final String quizName;
  // final String quizDescription;
  // final String quizCreator;
  const QuizDetails(this.quizId);
  @override
  _QuizDetailsState createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  // final TextEditingController quizTitleController =
  //     TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
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
              onPressed: () {
                print("Tap Save");
                // quizListGlobal.addAll([
                //   QuizComponent(quizTitleController.text, "Something", "duc"),
                //   SizedBox(height: 5),
                // ]);
                //quizNameGlobal = quizTitleController.text;
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
                          textField2(snapshot.data!.name),
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
                          textField1(snapshot.data!.description),
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
              controller: TextEditingController.fromValue(
                TextEditingValue(
                    text: text,
                    selection: TextSelection.collapsed(
                      offset: text.length,
                    )),
              ),
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
              controller: TextEditingController.fromValue(
                TextEditingValue(
                    text: text,
                    selection: TextSelection.collapsed(
                      offset: text.length,
                    )),
              ),
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
            IconSetting(),
          ],
        ),
      );
  Widget IconSetting() => Container(
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
      );

  @override
  void dispose() {
    //super.dispose();
    //quizTitleController.dispose();
    super.dispose();
  }
}
