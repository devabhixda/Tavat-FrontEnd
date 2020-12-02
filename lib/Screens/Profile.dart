import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
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
          Container(
            width: w,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical : 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Profile, 20", 
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
                ),
                SizedBox(height: 10),
                Text("Upcoming trips to Paris and London. Would love to swap travel stories with a fellow globetrotter. Love meeting new people.",
                  style: GoogleFonts.ptSans(
                    fontSize: 18
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 0.02 * h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: cred,
              child: Icon(Icons.edit, color: Colors.white),
            ),
            CircleAvatar(
              backgroundColor: cred,
              child: Icon(Icons.add_a_photo, color: Colors.white)
            ),
            CircleAvatar(
              backgroundColor: cred,
              child: Icon(Icons.settings, color: Colors.white)
            ),
          ],
        )
      )
    );
  }
}