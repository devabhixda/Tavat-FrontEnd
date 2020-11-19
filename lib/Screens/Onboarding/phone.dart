import 'package:connect/Screens/Onboarding/login.dart';
import 'package:connect/Screens/Onboarding/signup.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/Services/firestore_func.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';

class phone extends StatefulWidget {
  @override
  _phoneState createState() => _phoneState();
}
class _phoneState extends State<phone> {

  String phone;
  double h,w;
  bool exists;
  Auth auth = new Auth();
  String errorText = "";

  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold( 
      backgroundColor: bgrey,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
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
                    hintText: "Phone number",
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                  onChanged: (value) => {
                    setState(() {
                      phone = value;
                    })
                  },
                ),
              ),
            ),
            Text(
              errorText, style: TextStyle(fontSize: 12, color: Colors.red)
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
                if(phone != null)
                  getUserByPhone(phone).then((value) => value ? Navigator.push(context, MaterialPageRoute(builder: (context) => login(phone: phone))) : Navigator.push(context, MaterialPageRoute(builder: (context) => signup())))
                else
                  setState(() {
                    errorText = "Please enter a valid phone number";
                  })
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
                    auth.signInWithGoogle().then((value) => value ? Navigator.push(context, MaterialPageRoute(builder: (context) => login(phone: phone))) : Navigator.push(context, MaterialPageRoute(builder: (context) => signup())))
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