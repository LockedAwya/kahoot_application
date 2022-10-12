import 'package:flutter/material.dart';
import '../InitialScreen/inittial_screen.dart';
import '../utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../NotLoggedIn/no_auth.dart';
import './my_kahoots.dart';

class ProfileScreen extends StatefulWidget {
  final double borderWidth = 0.5;
  final double containerHeight = 70.0;
  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final double borderWidth = 0.5;
  final double containerHeight = 65;
  final double fontSize = 24;

  String? username = "";
  //late

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    secretPageState = "Profile";
    initial();
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey('username')) {
        username = prefs.getString('username');
      }
      // if (prefs.containsKey('token')) {
      //   //token = prefs.getString('token');
      //   token = true;
      // }
      //username = shared_preferences.stringGetter('username')!;
    });
  }

  Widget buttonInkWell({
    String? title,
    VoidCallback? onTap,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color bg = Colors.white,
    Color? textColor = Colors.black,
    IconData? iconData,
    double? iconSize,
    //double? width = double.infinity,
    double height = 65,
    double fontSize = 30,
  }) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          padding: padding,
          margin: margin,
          child: Text.rich(
            TextSpan(
              children: [
                WidgetSpan(child: Icon(iconData, size: iconSize)),
                TextSpan(
                  text: title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // light
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ), //BorderRadius.all
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            username ?? 'Profile',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black.withOpacity(1.0)),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 241, 241, 241),
        ),
        body: isAuth
            ? SafeArea(
                //child: _widgetOptions.elementAt(_selectedIndex),
                child: ListView(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 10.0),
                children: <Widget>[
                  buttonInkWell(
                    title: 'Profile Information',
                    onTap: () {},
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    iconData: Icons.person,
                    iconSize: 30,
                  ),
                  const SizedBox(height: 10), // <-- Set height
                  buttonInkWell(
                    title: 'Your kahoots',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyKahootScreen()));
                    },
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    iconData: Icons.person,
                    iconSize: 30,
                  ),
                  const SizedBox(height: 10), // <-- Set height
                  buttonInkWell(
                    title: 'Reports',
                    onTap: () {},
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    iconData: Icons.query_stats,
                    iconSize: 30,
                  ),
                  const SizedBox(height: 10),
                  buttonInkWell(
                    title: 'Log out',
                    onTap: () {
                      //print("tapped on container");
                      prefs.remove('username');
                      prefs.remove('token');
                      isAuth = false;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const InittialScreen()));
                    },
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 0.0),
                    iconData: Icons.logout,
                    iconSize: 30,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     //print("tapped on container");
                  //     prefs.remove('username');
                  //     prefs.remove('token');
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => const InittialScreen()));
                  //   },
                  //   child: Container(
                  //     height: containerHeight,
                  //     padding: EdgeInsets.all(15),
                  //     margin:
                  //         EdgeInsets.symmetric(vertical: 50.0, horizontal: 0.0),
                  //     child: Text(
                  //       'Log out',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold, // light
                  //         fontSize: fontSize,
                  //       ),
                  //     ),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.grey),
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(10),
                  //       ), //BorderRadius.all
                  //     ),
                  //   ),
                  // ),
                ],
              ))
            : (NoAuth()));
  }
}
