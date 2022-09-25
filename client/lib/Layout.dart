import '../Profile/ProfileScreen.dart';
import './Home/HomeScreen.dart';

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
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          // style: TextStyle(
          //   fontWeight: FontWeight.bold,
          //   fontSize: 20, // light
          // ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
