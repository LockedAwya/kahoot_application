import 'package:flutter/material.dart';
import './inittial_screen.dart';
import '../main.dart';

class Body extends StatelessWidget {
  const Body(this.chidren,
      {this.alignment = CrossAxisAlignment.center, Key? key})
      : super(key: key);
  final List<Widget> chidren;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.deepPurpleAccent,
      padding: EdgeInsets.only(bottom: 230.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _kahoot,
            Container(
              width: double.infinity,
              color: Colors.white,
              margin:
                  const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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

  Container get _kahoot => Container(
      margin: EdgeInsets.symmetric(
          vertical: 5.0, horizontal: 10.0), //apply padding to some sides only
      child: Text(
        "Kahoot!",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 40),
      ));
  // const Text(
  //       "Kahoot!",
  //       style: TextStyle(
  //           color: Colors.white, fontWeight: FontWeight.normal, fontSize: 40),
  //     );
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
    TextEditingController controller, bool obscureText) {
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
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(10),
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
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
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
