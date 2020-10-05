import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}
class _signupState extends State<signup> {
  double h,w;
  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.1 * h, horizontal: 0.1 * w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("FIND THE", style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w600
            )),
            Text("ONE", style: TextStyle(
              color: Color(0xFFF61B39),
              fontSize: 48,
              fontWeight: FontWeight.w600
            )),
            Card(
              margin: EdgeInsets.only(top: 0.02 * h, bottom: 0.01 * h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "email"
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 0.02 * h, bottom: 0.01 * h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "phone number"
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 0.02 * h, bottom: 0.01 * h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "password"
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 0.02 * h, bottom: 0.01 * h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "confirm password"
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: false,
                ),
                Text("I have read and agreed with all the ", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10)),
                Text("terms and conditions", style: TextStyle(color: Color(0xFFF61B39), fontStyle: FontStyle.italic, fontSize: 10))
              ],
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 0.30 * w, vertical: 0.02 * h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              color: Color(0xFFF61B39),
              child: Text("Sign up", style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              onPressed: () => {
                print("Pressed")
              },
            ),
          ],
        ),
      )
    );
  }
}