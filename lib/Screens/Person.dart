import 'package:connect/Screens/ChatBox.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Person extends StatefulWidget {
  @override
  _PersonState createState() => _PersonState();
}
class _PersonState extends State<Person> {
  double h,w;
  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile", 
          style: GoogleFonts.ptSans(
            fontSize: 24,
            color: Colors.black
          )
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,color: cred,),
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 0.5 * h,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 0.7 * w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Person, 20", 
                        style: GoogleFonts.ptSans(
                          fontSize: 28,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      Text("Likes Clubs, Bars, Hill Stations",
                        style: GoogleFonts.ptSans(
                          fontSize: 22,
                          color: cred
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 0.2 * w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: cred,
                        child: Icon(Icons.wine_bar, color: Colors.white),
                      ),
                      GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: cred,
                          child: Icon(Icons.message, color: Colors.white),
                        ),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBox()))
                        },
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0.05 * h),
            child: Container(
              child: Text("Upcoming trips to Paris and London. Would love to swap travel stories with a fellow globetrotter. Love meeting new people.",
                style: GoogleFonts.ptSans(
                  fontSize: 18
                ),
              )
            ),
          )
        ],
      )
    );
  }
}