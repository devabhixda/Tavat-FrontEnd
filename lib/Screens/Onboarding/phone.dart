import 'package:connect/Screens/Onboarding/email.dart';
import 'package:connect/Screens/Onboarding/login.dart';
import 'package:connect/Screens/Onboarding/otp.dart';
import 'package:connect/Screens/Onboarding/signup.dart';
import 'package:connect/Screens/home.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/Services/firestore_func.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

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
                    prefix: Text("+91 ")
                  ),
                  style: GoogleFonts.ptSans(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                  onChanged: (value) => {
                    setState(() {
                      phone = value;
                    })
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                  ],
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
                if(phone.length == 10) {
                  setEmail(phone+"@tavat.in"),
                  getUser(phone+"@tavat.in").then((value) => value ? Navigator.push(context, MaterialPageRoute(builder: (context) => login(phone: phone+"@tavat.in"))) : Navigator.push(context, MaterialPageRoute(builder: (context) => otp(phone: phone,))))
                }
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
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Image(image: AssetImage('assets/images/google.png'), height: 0.08 * h)
                  ),
                  onTap: () => {
                    auth.signInWithGoogle().then((value) => value ? Navigator.push(context, MaterialPageRoute(builder: (context) => Home())) : Navigator.push(context, MaterialPageRoute(builder: (context) => signup())))
                  },
                ),
                SizedBox(width: 0.1 * w),
                GestureDetector(
                  onTap: () => {
                    
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Image(image: AssetImage('assets/images/facebook.png'), height: 30),
                  )
                ),
                SizedBox(width: 0.1 * w),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => email()))
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: cred,
                    child: Icon(Icons.email, color: Colors.white, size: 30)
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }

  setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
  }
}