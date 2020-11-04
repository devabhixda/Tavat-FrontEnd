import 'package:connect/Screens/home.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}
class _signupState extends State<signup> {
  double h,w;
  String email, phone, ptemp, password, otp;
  Auth auth = new Auth();
  
  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: bgrey,
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
              color: cred,
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
                  onChanged: (value) => {
                    setState(() {
                      email = value;
                    })
                  },
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
                  onChanged: (value) => {
                    setState(() {
                      phone = value;
                    })
                  },
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
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                  onChanged: (value) => {
                    setState(() {
                      ptemp = value;
                    })
                  },
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
                  obscureText: true,
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
            Row(
              children: [
                Checkbox(
                  value: false,
                ),
                Text("I have read and agreed with all the ", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10)),
                Text("terms and conditions", style: TextStyle(color: cred, fontStyle: FontStyle.italic, fontSize: 10))
              ],
            ),
            Center(
              child: FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 0.30 * w, vertical: 0.02 * h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                color: cred,
                child: Text("Sign up", style: TextStyle(color: Colors.white, fontSize: 0.05 * w),
                ),
                onPressed: () => {
                  if(ptemp != password) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Password mismatch",
                          ),
                          content: Text("Your confirmed password do not match, please check"),
                          actions: [
                            FlatButton(
                              child: Text("OK"
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    )
                  } else {
                    auth.createAccount(email, password),
                    auth.verifyPhone(phone, context),
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Enter yout otp",
                          ),
                          content: TextField(
                            onChanged: (value) => {
                              otp = value
                            },
                          ),
                          actions: [
                            FlatButton(
                              child: Text("Verify"
                              ),
                              onPressed: () {
                                auth.verifyOtp(otp).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => home())));
                              },
                            )
                          ],
                        );
                      },
                    )
                  }
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => home()))
                },
              ),
            )
          ],
        ),
      )
    );
  }
}