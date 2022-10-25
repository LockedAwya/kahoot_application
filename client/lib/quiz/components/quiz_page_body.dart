import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled_folder/model/add_question_model.dart';
import 'package:untitled_folder/quiz/components/quiz_page.dart';
import '../../utils/widget.dart';

class QuizPageBody extends StatefulWidget {
  final int? values;
  const QuizPageBody(this.values);

  @override
  _QuizPageBodyState createState() => _QuizPageBodyState();
}

class _QuizPageBodyState extends State<QuizPageBody> {
  late TextEditingController fieldController;
  @override
  void initState() {
    super.initState();
    fieldController = new TextEditingController(text: widget.values.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListTile(
                onTap: () {
                  print("Tap select image");
                },
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                horizontalTitleGap: 1.0,
                title: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 200,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset('assets/icons/ic_pick.png',
                            fit: BoxFit.cover),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.0)),
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
                          style:
                              TextStyle(color: Color(0xFF6B6B6B), fontSize: 16),
                        )
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            textField(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonItem(
                    colors: Colors.red[500],
                    text: 'Add answer',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ButtonItem(
                    colors: Colors.lightBlue[900],
                    text: 'Add answer',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonItem(
                    colors: Colors.yellow[800],
                    text: 'Add answer\n(optional)',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ButtonItem(
                    colors: Colors.green[900],
                    text: 'Add answer\n(optional)',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
