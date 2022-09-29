import 'package:flutter/material.dart';
import './widget.dart';

import 'login_screen.dart';
import 'register_screen.dart';

class InittialScreen extends StatelessWidget {
  const InittialScreen({Key? key}) : super(key: key);
  final margin = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body([
        button("Login", () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginScreen()));
        }, bg: Colors.grey.shade400),
        button("Register", () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
        }, margin: EdgeInsets.symmetric(vertical: margin)),
        const Text(
          "OR",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        button("Play as a guest", () {},
            bg: Colors.grey.shade400, margin: EdgeInsets.only(top: margin)),
      ]),
    );
  }
}
