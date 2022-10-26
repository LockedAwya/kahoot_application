import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:untitled_folder/model/quiz_model.dart';

class CreateAnswer2 extends StatefulWidget {
  final String? textanswer;
  final bool isCorrect;
  const CreateAnswer2({Key? key, this.textanswer, this.isCorrect = false})
      : super(key: key);

  @override
  State<CreateAnswer2> createState() => _CreateAnswer2State();
}

class _CreateAnswer2State extends State<CreateAnswer2> {
  bool status = false;
  final answerController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAnswer();
  }

  setAnswer() {
    setState(() {
      answerController.text = widget.textanswer ?? '';
      status = widget.isCorrect;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ),
        title: const Text(
          "Add Answers",
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Enter Answer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                //  alignment: Alignment,
                children: [
                  TextFormField(
                    controller: answerController,
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
                  Visibility(
                    visible: status,
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
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Correct answer",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  FlutterSwitch(
                    width: 60.0,
                    height: 36.0,
                    valueFontSize: 40.0,
                    toggleSize: 30.0,
                    value: status,
                    borderRadius: 30.0,
                    padding: 8.0,
                    showOnOff: false,
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonItem(
                  onTap: () {
                    QuizModel quizModel = QuizModel(
                        text: answerController.text.trim(), isCorrect: status);
                    Navigator.pop(context, quizModel);
                  },
                  colors: Colors.lightBlue[900],
                  text: 'Done'),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonItem extends StatelessWidget {
  final Color? colors;
  final String text;
  final VoidCallback? onTap;

  const ButtonItem(
      {Key? key, required this.colors, required this.text, this.onTap})
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
          height: 60,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
