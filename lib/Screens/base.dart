import 'package:connect/Screens/History.dart';
import 'package:connect/Screens/Profile.dart';
import 'package:connect/Screens/around.dart';
import 'package:connect/Screens/Chat.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:connect/Screens/home.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}
class _BaseState extends State<Base> {
  double w,h;
  int selected = 2;
  List<Widget> _widgetOptions = [Profile(), History(), Home(), Around(), Chat()];

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _widgetOptions.elementAt(selected),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: cred,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: selected,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: ""
          ),
        ],
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      selected = index;
    });
  }
}