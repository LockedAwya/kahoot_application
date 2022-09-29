import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:untitled_folder/widget.dart';

import 'ValidateUtil.dart';
import 'inittial_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final margin = 0.0;
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const InittialScreen()),
              ModalRoute.withName('/'));
          return true;
        },
        child: Form(
          key: formkey,
          child: Column(
            children: [
              headerScreen("Sign In", () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }),
              Expanded(
                  child: Body(
                [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "Create an account",
                      style: _textStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...itemTextFormField("Username", (value) {
                    return ValidateUtil.isNameUser(value)
                        ? null
                        : "Username Invalid";
                  }).children,
                  ...itemTextFormField("Email", (value) {
                    return ValidateUtil.isEmail(value)
                        ? null
                        : "Username Invalid";
                  }).children,
                  ...itemTextFormField("Password", (value) {
                    return ValidateUtil.isPassUser(value)
                        ? null
                        : "Username Invalid";
                  }).children,
                  button("Register", () {
                    if (formkey.currentState?.validate() == false) {
                      showToast('Format Invalid',
                          position: ToastPosition.bottom);
                    }
                  },
                      textColor: Colors.white,
                      margin: const EdgeInsets.only(top: 20))
                ],
                alignment: CrossAxisAlignment.start,
              ))
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get _textStyle => const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black);
}
