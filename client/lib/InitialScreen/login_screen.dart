import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import '../utils/widget.dart';
//import '../services/auth_services.dart';
import '../utils/global_variables.dart';
import 'validate_util.dart';
//import 'inittial_screen.dart';
import '../utils/routing_names.dart';
import '../model/user_model.dart';
import '../api/index.dart';

//var dio = Dio();

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  //_LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final margin = 0.0;
  final formkey = GlobalKey<FormState>();
  String message = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    //prefs = await SharedPreferences.getInstance();
  }

  void signInFunc(String email, String password, BuildContext context) async {
    if (formkey.currentState?.validate() == false) {
      showToast('Format Invalid', position: ToastPosition.bottom);
    } else {
      var res = await loginAPI(email, password);

      if (res.statusCode == 200) {
        User user = User.fromJson(res.data);
        print(user.username);
        // prefs.setString('token', user.token);
        // prefs.setString('username', user.username);
        // prefs.setString('userId', user.id);
        username = user.username;
        userId = user.id;
        isAuth = true;
      }

      if (isAuth == true) {
        message = "Login success!";
        showToast(message, position: ToastPosition.bottom);
        if (!mounted) return;
        Navigator.pushNamed(context, SecretScreenView);
      } else {
        message = "Incorrect username or password!";
        showToast(message, position: ToastPosition.bottom);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
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
        //child: SingleChildScrollView(child:"Your widgets"))
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
                  //padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                  child: Container(
                      //decoration: BoxDecoration(border: Border.all()),
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
                  ...itemTextFormField(
                    "Email",
                    (value) {
                      return ValidateUtil.isEmail(value)
                          ? null
                          : "Email must be in correct form";
                    },
                    emailController,
                  ) //not display text, hence obscureText = false
                      .children,
                  ...itemTextFormField("Password", (value) {
                    return ValidateUtil.isPassUser(value)
                        ? null
                        : "Password Invalid";
                  }, passwordController,
                          obscureText:
                              true) //not display text, hence obscureText = true
                      .children,
                  button("Login", () {
                    signInFunc(
                        emailController.text, passwordController.text, context);
                  },
                      textColor: Colors.white,
                      margin: const EdgeInsets.only(top: 10)),
                ],
                alignment: CrossAxisAlignment.start,
              ))),
              //     child: Body(
              //   [
              //     Container(
              //       width: double.infinity,
              //       alignment: Alignment.center,
              //       child: Text(
              //         "Login",
              //         style: _textStyle,
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     ...itemTextFormField(
              //       "Email",
              //       (value) {
              //         return ValidateUtil.isEmail(value)
              //             ? null
              //             : "Email must be in correct form";
              //       },
              //       emailController,
              //     ) //not display text, hence obscureText = false
              //         .children,
              //     ...itemTextFormField("Password", (value) {
              //       return ValidateUtil.isPassUser(value)
              //           ? null
              //           : "Password Invalid";
              //     }, passwordController,
              //             obscureText:
              //                 true) //not display text, hence obscureText = true
              //         .children,
              //     button("Login", () {
              //       signInFunc(
              //           emailController.text, passwordController.text, context);
              //     },
              //         textColor: Colors.white,
              //         margin: const EdgeInsets.only(top: 10)),
              //   ],
              //   alignment: CrossAxisAlignment.start,
              // ))
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get _textStyle => const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black);

  @override
  void dispose() {
    //super.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
