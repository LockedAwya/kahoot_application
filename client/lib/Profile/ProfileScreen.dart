import 'package:flutter/material.dart';
import '../InitialScreen/inittial_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black.withOpacity(1.0)),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
      ),
      body: SafeArea(
          //child: _widgetOptions.elementAt(_selectedIndex),
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
        children: <Widget>[
          Container(
            height: containerHeight,
            // color: Colors.amber[600],
            padding: EdgeInsets.all(15),
            child: Text(
              'Profile Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize, // light
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
            height: containerHeight,
            padding: EdgeInsets.all(15),
            child: Text(
              'Your Kahoots',
              style: TextStyle(
                fontWeight: FontWeight.bold, // light
                fontSize: fontSize,
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
            height: containerHeight,
            padding: EdgeInsets.all(15),
            child: Text(
              'Reports',
              style: TextStyle(
                fontWeight: FontWeight.bold, // light
                fontSize: fontSize,
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ), //BorderRadius.all
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              //print("tapped on container");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InittialScreen()));
            },
            child: Container(
              height: containerHeight,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 0.0),
              child: Text(
                'Log out',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // light
                  fontSize: fontSize,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ), //BorderRadius.all
              ),
            ),
          ),
        ],
      )),
    );
  }
}
