import 'package:connect/Screens/Onboarding/phone.dart';
import 'package:connect/Screens/base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tavat()
    );
  }
}

class Tavat extends StatefulWidget {
  @override
  _TavatState createState() => _TavatState();
}

class _TavatState extends State<Tavat> {

  bool loading = true, login = false;

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
      setState(() {
        loading = false;
      });
    });
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    bool _login = prefs.getBool('login');
    if(_login != null) {
      setState(() {
        login = _login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: loading ? Center(
          child: CircularProgressIndicator()
        ) : login ? Base() : phone(),
      ),
    );
  }
}