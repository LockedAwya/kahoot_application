import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import '../utils/widget.dart';

import 'validate_util.dart';
// import 'inittial_screen.dart';
// import 'login_screen.dart';
import '../utils/global_variables.dart';
import '../routing_names.dart';
import '../api/index.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  //_RegisterScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final margin = 0.0;
  final formkey = GlobalKey<FormState>();

  void signUpFunc(String username, String email, String password,
      BuildContext context) async {
    if (formkey.currentState?.validate() == false) {
      //register failed
      showToast('Format Invalid', position: ToastPosition.bottom);
    } else {
      var res = await signupAPI(username, email, password);
      print(res.statusCode);
      if (res.statusCode == 200) {
        print(res.data.toString());
        print("YAYYYYYYYYYYYYYYYYYY REGISTERRRRR");
        if (!mounted) return;
        Navigator.pushNamed(context, LoginScreenView);
      } else {
        print(res.data);
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
        child: Form(
          key: formkey,
          child: Column(
            children: [
              headerScreen("Sign In", () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => LoginScreen()));
                Navigator.pushNamed(context, LoginScreenView);
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
                  ...itemTextFormField(
                    "Username",
                    (value) {
                      return ValidateUtil.isNameUser(value)
                          ? null
                          : "Username Invalid";
                    },
                    usernameController,
                  ) //not display text, hence obscureText = false
                      .children,
                  ...itemTextFormField(
                    "Email",
                    (value) {
                      return ValidateUtil.isEmail(value)
                          ? null
                          : "Username Invalid";
                    },
                    emailController,
                  ) //not display text, hence obscureText = false
                      .children,
                  ...itemTextFormField("Password", (value) {
                    return ValidateUtil.isPassUser(value)
                        ? null
                        : "Username Invalid";
                  }, passwordController,
                          obscureText:
                              true) //not display text, hence obscureText = true
                      .children,
                  button("Register", () {
                    signUpFunc(usernameController.text, emailController.text,
                        passwordController.text, context);
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
    usernameController.dispose();
    super.dispose();
  }
}
