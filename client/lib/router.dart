import 'package:flutter/material.dart';
import './InitialScreen/inittial_screen.dart';
import './InitialScreen/login_screen.dart';
import './InitialScreen/register_screen.dart';
import './SecretScreen/secret_screen.dart';
import './WaitingRoom/waiting_room.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/register':
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case '/login':
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case '/waiting_room':
      return MaterialPageRoute(builder: (context) => WaitingRoomScreen());
    case '/secret':
      //var arg = routeSettings.arguments;
      return MaterialPageRoute(
          builder: (context) => SecretScreen(title: "123456"));
    default:
      return MaterialPageRoute(builder: (context) => InittialScreen());
  }
}
