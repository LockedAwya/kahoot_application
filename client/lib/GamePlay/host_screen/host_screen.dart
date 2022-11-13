import 'package:flutter/material.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({Key? key}) : super(key: key);

  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  int start = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        leading: Container(
          width: 10,
          height: 10,
          alignment: Alignment.center,
          child: Text(
            "$start",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          margin: const EdgeInsets.only(top: 5),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.purple),
        ),
        leadingWidth: 70,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "What is the capital city \n of Vietnam?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: Image.asset("assets/images/img_host.png"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
