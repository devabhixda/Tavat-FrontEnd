import 'package:connect/Screens/ChatBox.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Around extends StatefulWidget {
  @override
  _AroundState createState() => _AroundState();
}
class _AroundState extends State<Around> {
  double h,w;
  @override    
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0.15 * h,
            centerTitle: true,
            title: Text("People", 
              style: GoogleFonts.ptSans(
                fontSize: 24,
                color: Colors.black
              )
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: cred,
              labelColor: cred,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("At Location", 
                    style: GoogleFonts.ptSans(
                      fontSize: 20
                    )
                  ),  
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Virtual", 
                    style: GoogleFonts.ptSans(
                      fontSize: 20
                    )
                  ),  
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0.05 * h),
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.1 * w),
                          leading: CircleAvatar(),
                          title: Text("Person"),
                          trailing: Container(
                            width: 0.3 * w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.wine_bar, color: cred, size: 0.08 * w), 
                                  onPressed: null
                                ),
                                IconButton(
                                  icon: Icon(Icons.message, color: cred, size: 0.08 * w), 
                                  onPressed: null
                                ),
                              ],
                            ),
                          )
                        );
                      }
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0.05 * h),
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.1 * w),
                          leading: CircleAvatar(),
                          title: Text("Person"),
                          trailing: Container(
                            width: 0.3 * w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.wine_bar, color: cred, size: 0.08 * w), 
                                  onPressed: null
                                ),
                                IconButton(
                                  icon: Icon(Icons.message, color: cred, size: 0.08 * w), 
                                  onPressed: null
                                ),
                              ],
                            ),
                          )
                        );
                      }
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}