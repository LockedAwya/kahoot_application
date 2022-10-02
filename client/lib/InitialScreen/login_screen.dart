import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import './register_screen.dart';
import './widget.dart';
import '../SecretScreen/secret_screen.dart';

import 'validate_util.dart';
//import 'inittial_screen.dart';
import '../routing_names.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final margin = 0.0;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: WillPopScope(
        onWillPop: () async {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => const InittialScreen()),
          //     ModalRoute.withName('/'));
          Navigator.pushNamed(context, InitialScreenView);
          return true;
        },
        child: Form(
          key: formkey,
          child: Column(
            children: [
              headerScreen("Sign up", () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => RegisterScreen()));
                Navigator.pushNamed(context, RegisterScreenView);
              }),
              Expanded(
                  child: Body(
                [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "Login",
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
                  ...itemTextFormField("Password", (value) {
                    return ValidateUtil.isPassUser(value)
                        ? null
                        : "Password Invalid";
                  }).children,
                  button("Login", () {
                    if (formkey.currentState?.validate() == false) {
                      showToast('Format Invalid',
                          position: ToastPosition.bottom);
                    } else {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         const SecretScreen(title: "Secret Screen")));
                      Navigator.pushNamed(context, SecretScreenView);
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
