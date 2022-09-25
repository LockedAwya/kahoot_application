import '../Profile/ProfileScreen.dart';
import './Home/HomeScreen.dart';
import './JoinGame/JoinGameScreen.dart';

import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, required this.title});

  final String title;

  final double borderWidth = 0.5;
  final double containerHeight = 70.0;

  @override
  State<Layout> createState() => _Layout();
}

class _Layout extends State<Layout> {
  final double borderWidth = 0.5;
  final double containerHeight = 65;
  final double fontSize = 24;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    JoinGameScreen(),
    Text(
      'Index 1: Host',
      style: optionStyle,
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        if (index != 1) {
          _selectedIndex = index;
        } else {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => _widgetOptions[1]),
          // );
          showModalBottomSheet<dynamic>(
              isScrollControlled: true,
              context: context,
              builder: (context) => _widgetOptions[1]);
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Join',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Host',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: onItemTapped,
      ),
    );
  }
}
