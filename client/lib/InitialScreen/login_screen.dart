import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import './widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../services/auth_services.dart';
import '../utils/global_variables.dart';
import 'validate_util.dart';
//import 'inittial_screen.dart';
import '../routing_names.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../utils/global_variables.dart';

var dio = Dio();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
  }

  signInFunc(String email, String password) async {
    var res = await dio.post(api_url + "/api/signin",
        data: {"email": email, "password": password});
    //print(res.statusCode);
    if (res.statusCode == 200) {
      //print("Response status: ${res.statusCode}");
      var data = res.data;
      // print(data['username']);
      // print(data['token']);
      print(res.data.toString());
      prefs.setString('token', data['token']);
      prefs.setString('username', data['username']);
      print("YAYYYYYYYYYYYYYYYYYY LOGINNNNNN");
    } else {
      //print("Login failed!");
      print(res.statusCode);
    }
  }

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
                    return ValidateUtil.isEmail(value)
                        ? null
                        : "Username Invalid";
                  }, emailController)
                      .children,
                  ...itemTextFormField("Password", (value) {
                    return ValidateUtil.isPassUser(value)
                        ? null
                        : "Password Invalid";
                  }, passwordController)
                      .children,
                  button("Login", () {
                    if (formkey.currentState?.validate() == false) {
                      showToast('Format Invalid',
                          position: ToastPosition.bottom);
                    } else {
                      //Navigator.pushNamed(context, SecretScreenView);
                      signInFunc(emailController.text, passwordController.text);
                      // print(shared_preferences.stringGetter('jwt'));
                      // print(shared_preferences.stringGetter('username'));
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

  @override
  void dispose() {
    //super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
