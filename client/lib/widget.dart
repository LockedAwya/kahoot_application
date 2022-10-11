import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled_folder/inittial_screen.dart';
import 'package:untitled_folder/main.dart';
import 'package:untitled_folder/model/add_question_model.dart';

class Body extends StatelessWidget {
  Body(this.chidren, {this.alignment = CrossAxisAlignment.center, Key? key})
      : super(key: key);
  List<Widget> chidren;
  CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _kahoot,
            Container(
              width: double.infinity,
              color: Colors.white,
              margin: const EdgeInsets.only(left: 25, right: 25, top: 40),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: alignment,
                children: chidren,
              ),
            )
          ],
        ),
      ),
    );
  }

  Text get _kahoot => const Text(
        "Kahoot!",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 40),
      );
}

Widget button(String title, VoidCallback onTap,
    {EdgeInsets? margin,
    Color bg = Colors.deepPurple,
    Color? textColor = Colors.black,
    double? width = double.infinity,
    double? height = 40,
    double? fontSize = 18,
    double radius = 8.0}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: bg,
      ),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: fontSize),
      ),
    ),
  );
}

Column itemTextFormField(String name, String? Function(String?) validator,
    {String? hintText, bool obscureText = false}) {
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        name,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
      ),
      const SizedBox(
        height: 5,
      ),
      SizedBox(
        height: 40,
        child: TextFormField(
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFB8B8B8)),
            hintText: hintText,
            contentPadding: const EdgeInsets.all(10),
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
        ),
      )
    ],
  );
}

Widget headerScreen(String title, VoidCallback onTap) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                globalKey.currentContext!,
                MaterialPageRoute(
                    builder: (BuildContext context) => const InittialScreen()),
                ModalRoute.withName('/'));
          },
          child: const Text("Cancel",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 13)),
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: button(title, onTap,
              width: 70, height: 25, bg: Colors.white, fontSize: 13, radius: 3),
        ))
      ],
    ),
  );
}

class AppButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final double? height;
  final double? width;

  const AppButton({super.key, this.text, this.onTap, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onTap,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
          side: MaterialStateProperty.all(const BorderSide(
            color: Colors.blue,
            width: 1.0,
          )),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        ),
        child: Text(
          text ?? '',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AddQuestionItem extends StatelessWidget {
  final AddQuestionModel data;
  final VoidCallback? onTap;
  const AddQuestionItem({Key? key, required this.data, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height * 0.08,
            child: Column(
              children: [
                Image.asset(
                  data.image ?? "",
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(data.title ?? "",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.teal),
              width: 20,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: const Icon(
                Icons.star,
                color: Colors.white,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
