import 'package:connect/Screens/Onboarding/signup.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  final phone;
  login({this.phone});
  
  @override
  _loginState createState() => _loginState();
}
class _loginState extends State<login> {

  String password;
  double h,w;
  Auth auth = new Auth();

  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold( 
      backgroundColor: bgrey,
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 0.35 * h,
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
                    hintText: "Password"
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                  onChanged: (value) => {
                    setState(() {
                      password = value;
                    })
                  },
                ),
              ),
            ),
            SizedBox(
              height: 0.1 * h,
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 0.37 * w, vertical: 0.02 * h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              color: cred,
              child: Text("Next", style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              onPressed: () => {
                auth.signIn(widget.phone, password)
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.05 * h, bottom: 0.03 * h),
              child: Text("or login with"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Card(
                    shape: CircleBorder(),
                    elevation: 5,
                    child: Image(image: AssetImage('assets/images/google.png'), height: 0.08 * h)
                  ),
                  onTap: () => {
                    print("[re"),
                    auth.signInWithGoogle()
                  },
                ),
                SizedBox(width: 0.1 * w),
                Card(
                  shape: CircleBorder(),
                  elevation: 5,
                  child: Image(image: AssetImage('assets/images/fb.png'), height: 0.08 * h)
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
                  child: Text("sign up", style: TextStyle(color: cred, fontStyle: FontStyle.italic, fontSize: 18))
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}