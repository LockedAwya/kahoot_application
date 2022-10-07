import '../Profile/profile_screen.dart';
import '../Home/home_screen.dart';
import '../JoinGame/join_game_screen.dart';
import '../HostGame/host_game_screen.dart';
import 'package:flutter/material.dart';

class SecretScreen extends StatefulWidget {
  final String title;
  SecretScreen({super.key, required this.title});

  final double borderWidth = 0.5;
  final double containerHeight = 70.0;
  //print(shared_preferences.stringGetter('username'));

  @override
  State<SecretScreen> createState() => _SecretScreen();
}

class _SecretScreen extends State<SecretScreen> {
  final double borderWidth = 0.5;
  final double containerHeight = 65;
  final double fontSize = 24;
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    JoinGameScreen(),
    HostGameScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black, width: 1.0))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white, // <-- This works for fixed
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
    );
  }
}
