//import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:flutter_driver/driver_extension.dart';
//import 'package:integration_test/integration_test.dart';
import 'package:untitled_folder/InitialScreen/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled_folder/main.dart';
//import 'package:untitled_folder/quiz/components/quiz_page.dart' as quizPage;

void main() {
  group('initial_screens', () {
    testWidgets("first_screen", (tester) async {
      await tester.pumpWidget(MyApp());
      final loginButtonFinder = find.byKey(Key("Login"));
      expect(loginButtonFinder, findsOneWidget);
      await tester.tap(loginButtonFinder);
    });

    // Widget testWidget = MediaQuery(
    //   data: MediaQueryData(),
    //   child: MaterialApp(home: LoginScreen()),
    // );
  });

  group('login_screen', () {
    Widget testWidget = MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(home: LoginScreen()),
    );
    testWidgets("type_username", (tester) async {
      await tester.pumpWidget(testWidget);
      final usernameFinder = find.byKey(Key("Username"));
      await tester.enterText(usernameFinder, "test1@gmail.com");
      expect(find.text("test1@gmail.com"), findsOneWidget);
      //await Future.delayed(Duration(seconds: 1));
    });

    testWidgets("type_password", (tester) async {
      await tester.pumpWidget(testWidget);
      final usernameFinder = find.byKey(Key("Password"));
      await tester.enterText(usernameFinder, "123456789");
      expect(find.text("123456789"), findsOneWidget);
      //await Future.delayed(Duration(seconds: 1));
    });

    testWidgets("click_login_button", (tester) async {
      await tester.pumpWidget(testWidget);
      //await tester.tap(find.byType();
      final loginButtonFinder = find.byKey(Key("Login"));
      expect(loginButtonFinder, findsOneWidget);
      // await tester.tap(loginButtonFinder);
    });
  });
}
