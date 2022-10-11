import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled_folder/model/add_question_model.dart';
import 'package:untitled_folder/quiz_page/quiz_page.dart';
import 'package:untitled_folder/widget.dart';

class AddQuestion extends StatefulWidget {
  final int value;
  const AddQuestion({Key? key, this.value = 0}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  List<AddQuestionModel> listTestnowledge = [
    AddQuestionModel(title: 'Quiz', image: 'assets/images/img_0.png'),
    AddQuestionModel(title: 'True or False', image: 'assets/images/img_1.png'),
    AddQuestionModel(title: 'Puzzle', image: 'assets/images/img_10.png'),
    AddQuestionModel(title: 'Type answer', image: 'assets/images/img_5.png'),
    AddQuestionModel(title: 'Quiz + Audio', image: 'assets/images/img_8.png'),
    AddQuestionModel(title: 'Slider', image: 'assets/images/img_7.png'),
  ];

  List<AddQuestionModel> listCollectionOpinions = [
    AddQuestionModel(title: 'Word cloud', image: 'assets/images/img_2.png'),
    AddQuestionModel(title: 'Poll', image: 'assets/images/img_9.png'),
    AddQuestionModel(title: 'Open-ended', image: 'assets/images/img_2.png'),
    AddQuestionModel(title: 'Brainstorm', image: 'assets/images/img_12.png'),
    AddQuestionModel(title: 'Drop pin', image: 'assets/images/img_13.png'),
  ];
  List<AddQuestionModel> listPresentInfo = [
    AddQuestionModel(title: 'Slide', image: 'assets/images/img_6.png')
  ];
  int value = 0;
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
          "Add Question",
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: Text(
                "Test knowledge",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.58),
                itemBuilder: (_, index) {
                  return AddQuestionItem(
                    onTap: () {
                      changePage(index, context);
                    },
                    data: listTestnowledge[index],
                  );
                },
                itemCount: listTestnowledge.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Collect opinions",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.58),
                itemBuilder: (_, index) {
                  return AddQuestionItem(
                    data: listCollectionOpinions[index],
                  );
                },
                itemCount: listCollectionOpinions.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Present info",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.58),
                itemBuilder: (_, index) {
                  return AddQuestionItem(
                    data: listPresentInfo[index],
                  );
                },
                itemCount: listPresentInfo.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  changePage(int index, BuildContext context) async {
    switch (index) {
      case 0:
        setState(() {
          value = widget.value + 1;
        });
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuizPage(
                  values: value,
                )));

        break;
      case 1:
        break;
    }
  }
}