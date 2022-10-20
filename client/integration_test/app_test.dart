//import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:flutter_driver/driver_extension.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled_folder/main.dart' as app;

void main() {
  group('app_test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("login_fail", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      //initial screen
      final loginButtonFinder = find.byKey(Key("Login"));
      await Future.delayed(Duration(seconds: 1));

      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();
      //login screen
      await Future.delayed(Duration(seconds: 1));
      final usernameField = find.byKey(Key("Username"));
      final passwordField = find.byKey(Key("Password"));
      final loginButtonFinder2 = find.byKey(Key("Login"));

      await tester.enterText(usernameField, "test1@gmail.com");
      await Future.delayed(Duration(seconds: 1));
      await tester.enterText(passwordField, "1234567");
      await Future.delayed(Duration(seconds: 2));
      //await tester.pumpAndSettle();

      await tester.tap(loginButtonFinder2);
      await tester.pumpAndSettle();

      expect(find.text("Incorrect username or password!"), findsOneWidget);
    });
  });
}
