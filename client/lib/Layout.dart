import 'dart:ffi';

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
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    // Text(
    //   'Index 2: Business',
    //   style: optionStyle,
    // ),
    ListView(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
      children: <Widget>[
        Container(
          height: 65,
          // color: Colors.amber[600],
          padding: EdgeInsets.all(15),
          child: Text(
            'Profile Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24, // light
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ), //BorderRadius.all
          ),
        ),
        SizedBox(height: 10), // <-- Set height
        Container(
          height: 65,
          padding: EdgeInsets.all(15),
          child: Text(
            'Your Kahoots',
            style: TextStyle(
              fontWeight: FontWeight.bold, // light
              fontSize: 24,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ), //BorderRadius.all
          ),
        ),
        SizedBox(height: 10), // <-- Set height
        Container(
          height: 65,
          padding: EdgeInsets.all(15),
          child: Text(
            'Reports',
            style: TextStyle(
              fontWeight: FontWeight.bold, // light
              fontSize: 24,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ), //BorderRadius.all
          ),
        ),
        SizedBox(height: 10), // <-- Set height
        Container(
          height: 65,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 0.0),
          child: Text(
            'Log out',
            style: TextStyle(
              fontWeight: FontWeight.bold, // light
              fontSize: 24,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ), //BorderRadius.all
          ),
        ),
      ],
    )
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20, // light
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
        //     child: ListView(
        //   padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
        //   children: <Widget>[
        //     Container(
        //       height: containerHeight,
        //       // color: Colors.amber[600],
        //       padding: EdgeInsets.all(15),
        //       child: Text(
        //         'Profile Information',
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: fontSize, // light
        //         ),
        //       ),
        //       decoration: BoxDecoration(
        //         border: Border.all(color: Colors.grey),
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(10),
        //         ), //BorderRadius.all
        //       ),
        //     ),
        //     SizedBox(height: 10), // <-- Set height
        //     Container(
        //       height: containerHeight,
        //       padding: EdgeInsets.all(15),
        //       child: Text(
        //         'Your Kahoots',
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold, // light
        //           fontSize: fontSize,
        //         ),
        //       ),
        //       decoration: BoxDecoration(
        //         border: Border.all(color: Colors.grey),
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(10),
        //         ), //BorderRadius.all
        //       ),
        //     ),
        //     SizedBox(height: 10), // <-- Set height
        //     Container(
        //       height: containerHeight,
        //       padding: EdgeInsets.all(15),
        //       child: Text(
        //         'Reports',
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold, // light
        //           fontSize: fontSize,
        //         ),
        //       ),
        //       decoration: BoxDecoration(
        //         border: Border.all(color: Colors.grey),
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(10),
        //         ), //BorderRadius.all
        //       ),
        //     ),
        //     SizedBox(height: 10), // <-- Set height
        //     Container(
        //       height: containerHeight,
        //       padding: EdgeInsets.all(15),
        //       margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 0.0),
        //       child: Text(
        //         'Log out',
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold, // light
        //           fontSize: fontSize,
        //         ),
        //       ),
        //       decoration: BoxDecoration(
        //         border: Border.all(color: Colors.grey),
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(10),
        //         ), //BorderRadius.all
        //       ),
        //     ),
        //   ],
        // )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
