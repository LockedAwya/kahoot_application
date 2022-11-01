import 'package:flutter/material.dart';
import '../utils/widget.dart';

import '../utils/routing_names.dart';
// import 'login_screen.dart';
// import 'register_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);
  final margin = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body([
        button("Login", () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => LoginScreen()));
          Navigator.pushNamed(context, LoginScreenView);
        }, bg: Colors.grey.shade400),
        button("Register", () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
          Navigator.pushNamed(context, RegisterScreenView);
        }, margin: EdgeInsets.symmetric(vertical: margin)),
        const Text(
          "OR",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        button("Play as a guest", () {
          //print("tapped on container");
          Navigator.of(context).pushNamed(SecretScreenView);
          //Navigator.pushNamed(context, InitialScreenView);
        }, bg: Colors.grey.shade400, margin: EdgeInsets.only(top: margin)),
      ]),
    );
  }
}
