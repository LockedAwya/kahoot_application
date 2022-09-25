import 'package:flutter/material.dart';
import '../Profile/ListViewScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          Text("This is home page", style: TextStyle(fontSize: 24)),
          ElevatedButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListViewScreen()),
                    ),
                  },
              child: const Text('Go to another page')),
        ]),
      ),
    );
  }
}
