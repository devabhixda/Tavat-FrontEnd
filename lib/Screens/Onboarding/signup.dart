import 'dart:io';
import 'package:connect/Screens/base.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}
class _signupState extends State<signup> {
  double h,w;
  String email, name, ptemp, password, gender;
  bool tnc = false;
  int _radiobtnvalue = -1;
  Auth auth = new Auth();
  DateTime pickedDate;
  File _imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getEmail();
  }
  
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String e = prefs.getString("email");
    setState(() {
      email = e;
    });
    print(email);
  }

  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgrey,
      body: SingleChildScrollView(
        child: Container(
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
              Center(
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shadowColor: cred,
                  shape: CircleBorder(),
                  child: GestureDetector(
                    onTap: () => {
                      pickImage()
                    },
                    child: CircleAvatar(
                      radius: 0.1 * h,
                      backgroundColor: Colors.white,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile) : AssetImage('assets/images/add.png'),
                    ),
                  ),
                )
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
                      hintText: "Name"
                    ),
                    style: GoogleFonts.ptSans(
                      fontSize: 24,
                      fontStyle: FontStyle.italic
                    ),
                    onChanged: (value) => {
                      setState(() {
                        name = value;
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
                  child: ListTile(
                    title: pickedDate == null ? Text("D.O.B",
                      style: GoogleFonts.ptSans(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey
                      ),
                    ): Text("${pickedDate.day}-${pickedDate.month}-${pickedDate.year}",
                      style: GoogleFonts.ptSans(
                        fontSize: 22,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: _pickDate,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  addRadio(0, 'Male'),
                  addRadio(1, 'Female'),
                  addRadio(2, 'Others'),
                ],
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
                    value: tnc,
                    onChanged: terms,
                    activeColor: cred,
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
                    } else if(!tnc) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Terms and Conditions",
                            ),
                            content: Text("Please agree to the terms and conditions before proceeding."),
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
                      auth.createAccount(_imageFile, email, password, name, pickedDate.toIso8601String(), gender).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Base()))),
                    }
                  },
                ),
              )
            ],
          ),
        )
      )
    );
  }

  _pickDate() async {
   DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: DateTime.now(),
    );

    if(date != null)
      setState(() {
        pickedDate = date;
      });
  }

  Row addRadio(int btnValue, String title) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Radio(
        activeColor: cred,
        value: btnValue,
        groupValue: _radiobtnvalue,
        onChanged: _handleradiobutton,
      ),
      Text(title)
    ],
    );
  }

  void _handleradiobutton(int value) {
    setState(() {
      _radiobtnvalue = value;
      switch (value) {
        case 0:
          gender = "male";
          break;
        case 1:
          gender = "female";
          break;
        case 2:
          gender = 'other';
          break;
        default:
          gender = null;
      }
    });
  }

  void terms(bool value) {
    setState(() {
      tnc = value;
    });
  }

  pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }
}