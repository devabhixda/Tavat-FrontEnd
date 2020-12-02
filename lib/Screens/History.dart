import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}
class _HistoryState extends State<History> {
  double h,w;
  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("History", 
          style: GoogleFonts.ptSans(
            fontSize: 24,
            color: Colors.black
          )
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0.02 * h),
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 0.05 * w, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.05 * w, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Club Palooza",
                              style: GoogleFonts.ptSans(
                                fontSize: 22
                              ),
                            ),
                            Text("111, MG road, Bangalore, India",
                              style: GoogleFonts.ptSans(
                                fontSize: 18
                              ),
                            ),
                            Text("Visited on : 11/11/20",
                              style: GoogleFonts.ptSans(
                                fontSize: 16
                              ),
                            )
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: cred,
                          radius: 0.03 * h,
                          child: Image.asset('assets/images/pin.png')
                        )
                      ],
                    )
                  )
                );
              }
            ),
          )
        ],
      )
    );
  }
}