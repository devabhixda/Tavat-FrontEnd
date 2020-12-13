import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/Screens/base.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Questions extends StatefulWidget {
  final String uid;
  Questions({this.uid});
  @override
  _QuestionsState createState() => _QuestionsState();
}
class _QuestionsState extends State<Questions> {
  double h,w;
  Auth auth = new Auth();
  Stream que;
  int selected = 0;

  void initState() {
    super.initState();
    getQue();
  }

  getQue() async {
    Stream qs = await auth.getQuestions();
    setState(() {
      que = qs;
    });
  }

  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: que,
          builder: (context, snapshot) {
            return snapshot.hasData ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data.documents[selected]["title"], style: GoogleFonts.ptSans(color: cred, fontSize: 32)),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: cred,
                  child: Container(
                    width: 0.8 * w,
                    height: 0.4 * h,
                    padding: EdgeInsets.all(0.03 * w),
                    child: Column(
                      children: [
                        Container(
                          height: 0.1 * h,
                          width: 0.65 * w,
                          child: Center(
                            child: Text(snapshot.data.documents[selected]["que"], style: GoogleFonts.ptSans(color: Colors.white, fontSize: 24)),
                          )
                        ),
                        Card(
                          color: Color(0xFFF26578),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            width: 0.65 * w,
                            height: 0.25 * h,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                                child: TextField(
                                maxLines: 10,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.ptSans(
                                  fontSize: 24,
                                  color: Colors.white
                                ),
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.05 * h,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  color: cred,
                  onPressed: () {
                    if(snapshot.data.size < selected) {
                      setState(() {
                        selected++;
                      });
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Base()));
                    }
                  },
                  child: Text("Next",
                    style: GoogleFonts.ptSans(
                      color: Colors.white,
                      fontSize: 24
                    ),
                  ),
                )
              ],
            ) : SpinKitDoubleBounce(
              color: cred,
              size: 30.0,
            );
          },
        ),
      )
    );
  }
}