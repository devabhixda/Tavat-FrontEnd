import 'package:flutter/material.dart';
import 'package:connect/consts.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}
class _profileState extends State<profile> {

  double h,w;

  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold( 
      backgroundColor: bgrey,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        
      )
    );
  }
}