import 'package:connect/Screens/Onboarding/login.dart';
import 'package:connect/Screens/Onboarding/signup.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/Services/firestore_func.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

class email extends StatefulWidget {
  @override
  _emailState createState() => _emailState();
}
class _emailState extends State<email> {

  String email;
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
                    hintText: "Email",
                  ),
                  style: GoogleFonts.ptSans(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                  onChanged: (value) => {
                    setState(() {
                      email = value;
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
                if(EmailValidator.validate(email)) {
                  setEmail(email),
                  getUser(email).then((value) => value ? Navigator.push(context, MaterialPageRoute(builder: (context) => login(phone: email))) : Navigator.push(context, MaterialPageRoute(builder: (context) => signup()))),
                }
                else
                  setState(() {
                    errorText = "Please enter a valid email";
                  })
              },
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