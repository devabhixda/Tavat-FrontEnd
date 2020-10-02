import 'package:connect/Screens/Onboarding/signup.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}
class _loginState extends State<login> {
  double h,w;
  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold( 
      backgroundColor: Color(0xFFF1F1F1),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 0.4 * h,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "username"
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Can't remember your password? ", style: TextStyle(fontStyle: FontStyle.italic),),
                Text("reset here", style: TextStyle(color: Color(0xFFF61B39), fontStyle: FontStyle.italic))
              ],
            ),
            SizedBox(
              height: 0.03 * h,
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 0.38 * w, vertical: 0.02 * h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              color: Color(0xFFF61B39),
              child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              onPressed: () => {
                print("Pressed")
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 0.03 * h),
              child: Text("or login with"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: CircleBorder(),
                  elevation: 5,
                  child: Image(image: AssetImage('assets/images/google.png'), height: 50)
                ),
                SizedBox(width: 0.1 * w),
                Card(
                  shape: CircleBorder(),
                  elevation: 5,
                  child: Image(image: AssetImage('assets/images/fb.png'), height: 50)
                ),
              ],
            ),
            SizedBox(
              height: 0.05 * h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => signup()));
                  },
                  child: Text("sign up", style: TextStyle(color: Color(0xFFF61B39), fontStyle: FontStyle.italic, fontSize: 18))
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}