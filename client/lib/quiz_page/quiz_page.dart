import 'package:flutter/material.dart';
import 'package:untitled_folder/add_question/add_question.dart';

class QuizPage extends StatefulWidget {
  final int? values;
  const QuizPage({Key? key, this.values}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            alignment: Alignment.center,
            iconSize: 20,
            icon: Image.asset(
              'assets/icons/ic_three_dot.png',
              width: 20,
              height: 20,
            ),
            onPressed: () {
              print("Tap Save");
            },
          ),
        ],
      ),
      persistentFooterButtons: [
        Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.values,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blueAccent, width: 2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                fieldController.text,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AddQuestion(value: widget.values ?? 1)));
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
            )),
      ],
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

class ButtonItem extends StatelessWidget {
  final Color? colors;
  final String text;

  const ButtonItem({Key? key, required this.colors, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5.0),
      color: colors,
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.43,
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
