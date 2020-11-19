import 'package:connect/Screens/Onboarding/phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

  bool loading = true;

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: loading ? Center(
          child: CircularProgressIndicator()
        ) : phone() ,
      ),
    );
  }
}