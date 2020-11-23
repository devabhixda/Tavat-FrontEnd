import 'package:connect/Services/auth.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class otp extends StatefulWidget {
  otp({@required this.phone});
  final String phone;
  @override
  _otpState createState() => _otpState();
}
class _otpState extends State<otp> {

  String otp;
  double h,w;
  bool exists;
  String errorText = "";
  Auth auth = new Auth();

  void initState() {
    super.initState();
    auth.verifyPhone("+91"+widget.phone, context);
  }

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
                    hintText: "OTP",
                  ),
                  style: GoogleFonts.ptSans(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                  onChanged: (value) => {
                    setState(() {
                      otp = value;
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
                auth.verifyOtp(widget.phone, otp, context)
              },
            ),
          ],
        ),
      )
    );
  }
}