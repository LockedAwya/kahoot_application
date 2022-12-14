import 'package:flutter/material.dart';
import '../InitialScreen/initial_screen.dart';
import '../InitialScreen/login_screen.dart';
import '../InitialScreen/register_screen.dart';
import '../SecretScreen/secret_screen.dart';
import '../GamePlay/WaitingRoom/waiting_room.dart';
import '../SecretScreen/NotLoggedIn/no_auth.dart';
import '../GamePlay/WaitingRoom/game_pin.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/register':
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case '/login':
      return MaterialPageRoute(builder: (context) => LoginScreen());
    // case '/waiting_room':
    //   return MaterialPageRoute(builder: (context) => WaitingRoomScreen());
    case '/secret':
      //var arg = routeSettings.arguments;
      return MaterialPageRoute(builder: (context) => SecretScreen());
    case '/waiting_room':
      return MaterialPageRoute(builder: (context) => GamePin());
    // case '/no_auth':
    //   return MaterialPageRoute(builder: (context) => NoAuth());
    default:
      return MaterialPageRoute(builder: (context) => InitialScreen());
  }
}
