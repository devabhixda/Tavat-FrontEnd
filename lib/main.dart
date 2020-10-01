import 'package:connect/Screens/Onboarding/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Connect());
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