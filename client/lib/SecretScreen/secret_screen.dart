import 'Profile/profile_screen.dart';
import 'Home/home_screen.dart';
import '../GamePlay/JoinGame/join_game_screen.dart';
import '../GamePlay/HostGame/host_game_screen.dart';
import 'package:flutter/material.dart';
import '../utils/global_variables.dart';
import 'NotLoggedIn/no_auth.dart';

class SecretScreen extends StatefulWidget {
  //final String title;
  //final bool isAuth;
  //SecretScreen({super.key});

  // bool get auth {
  //   return isAuth;
  // }

  final double borderWidth = 0.5;
  final double containerHeight = 70.0;
  //print(shared_preferences.stringGetter('username'));

  @override
  State<SecretScreen> createState() => _SecretScreen();
}

//bool token = false;

//List<Widget> _widgetOptions2 = <Widget>[];

class _SecretScreen extends State<SecretScreen> {
  final double borderWidth = 0.5;
  final double containerHeight = 65;
  final double fontSize = 24;
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  String? username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {}

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      JoinGameScreen(),
      isAuth == true ? HostGameScreen() : NoAuth(),
      isAuth == true ? (ProfileScreen()) : NoAuth(),
    ];
    void onItemTapped(int index) {
      setState(() {
        //print('Param is $title');
        if (index != 1) {
          _selectedIndex = index;
        } else {
          showModalBottomSheet<dynamic>(
              isScrollControlled: true,
              context: context,
              builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  child: _widgetOptions[1]));
        }
      });
    }

    Future<bool> _onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => isAuth == false
            ? (AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(false), //<-- SEE HERE
                    child: new Text('No'),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(true), // <-- SEE HERE
                    child: new Text('Yes'),
                  ),
                ],
              ))
            : (AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to log out?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(false), //<-- SEE HERE
                    child: new Text('No'),
                  ),
                  TextButton(
                    onPressed: () => {
                      // prefs.remove("username"),
                      // prefs.remove("token"),
                      resetGlobalVariable(),
                      //isAuth = false,
                      Navigator.of(context).pop(true)
                    }, // <-- SEE HERE
                    child: new Text('Yes'),
                  ),
                ],
              )),
      ));
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.black, width: 1.0))),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white, // <-- This works for fixed
            key: Key('BottomNavigationBar'),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups_outlined, size: 50),
                label: 'Join',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.quiz, size: 50),
                label: 'Host',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }
}
