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
    testWidgets("Full app", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      //initial screen
      final loginButtonFinder = find.byKey(Key("Login"));
      await Future.delayed(Duration(seconds: 1));

      await tester.tap(loginButtonFinder);
      //login screen
      await Future.delayed(Duration(seconds: 1));
      final usernameField = find.byKey(Key("Username"));
      final passwordField = find.byKey(Key("Password"));
      final loginButtonFinder2 = find.byKey(Key("Login"));

      await tester.enterText(usernameField, "test1@gmail.com");
      await Future.delayed(Duration(seconds: 1));
      await tester.enterText(passwordField, "123456789");
      await Future.delayed(Duration(seconds: 1));

      await tester.tap(loginButtonFinder2);
      //await tester.pumpAndSettle();
      //home screen
      /**
       * tab profile
       */
      //final tabProfile = find.byType(BottomNavigationBarItem).at(3);
      //await find('BottomNavigationBar');
      // await Future.delayed(Duration(seconds: 5));
      // final tabProfile = find.byIcon(Icons.person);
      // await tester.tap(tabProfile);
      // await Future.delayed(Duration(seconds: 3));
      // final tabLogout = find.byKey(Key("Log out"));
      // await tester.tap(tabLogout);
      // await Future.delayed(Duration(seconds: 1));
    });
  });
}
