import 'package:flutter/material.dart';
import 'package:untitled_folder/SecretScreen/quiz/components/add_question.dart';
import '../../utils/widget.dart';
import 'my_kahoots.dart';
//import 'components/quiz_component.dart';
import '../../utils/global_variables.dart';
import '../../api/index.dart';
import '../../model/quiz_model.dart';

class CreateKahoot extends StatefulWidget {
  //final List<Widget> quizList;

  const CreateKahoot({Key? key}) : super(key: key);
  //const CreateKahoot({required this.quizList});

  @override
  _CreateKahootState createState() => _CreateKahootState();
}

class _CreateKahootState extends State<CreateKahoot> {
  final TextEditingController quizTitleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    //prefs = await SharedPreferences.getInstance();
    setState(() {
      // username = prefs.getString('username') as String;
      // userId = prefs.getString('userId') as String;
      //username = shared_preferences.stringGetter('username')!;
    });
    //prefs = await SharedPreferences.getInstance();
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
              saveQuizFunc(
                  quizTitleController.text,
                  quizTitleController.text,
                  "" /**background */,
                  userId,
                  username,
                  10 /** */,
                  20 /**timer */,
                  0 /**number of question */,
                  [] /**question list */,
                  context);
              //             saveQuizFunc(
              // String name,
              // String description,
              // String background,
              // String creatorId,
              // String creatorName,
              // int scorePerQuestion,
              // int timer,
              // int numberOfQuestion,
              // List questionList,
              // BuildContext context)
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
                  height: 260,
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
              height: 20,
            ),
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
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppButton(
                  width: 180,
                  height: 60,
                  text: 'Add Question',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddQuestion()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

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
            )
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
