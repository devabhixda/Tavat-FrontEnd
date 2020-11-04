import 'package:connect/Screens/Onboarding/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Connect());
  Firebase.initializeApp();
}
class Connect extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}