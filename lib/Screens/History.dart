import 'package:connect/Services/auth.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}
class _HistoryState extends State<History> {

  Stream history;
  String uid;
  Auth auth = new Auth();

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String me = prefs.getString('uid');
    setState(() {
      uid = me;
    });
    auth.getHistory(uid).then((snapshots) {
      setState(() {
        history = snapshots;
      });
    });
  }

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
            child: StreamBuilder(
              stream: history,
              builder: (context, snapshot){
                return snapshot.hasData ?  ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
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
                                Text(snapshot.data.documents[index]["location"],
                                  style: GoogleFonts.ptSans(
                                    fontSize: 22
                                  ),
                                ),
                                Container(
                                  width: 0.6 * w,
                                  child: Text(snapshot.data.documents[index]["vincinity"],
                                    style: GoogleFonts.ptSans(
                                      fontSize: 18
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text("Visited on : "+snapshot.data.documents[index]["date"],
                                  style: GoogleFonts.ptSans(
                                    fontSize: 16
                                  ),
                                )
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: cred,
                              radius: 0.03 * h,
                              child: SvgPicture.asset('assets/images/pin.svg')
                            )
                          ],
                        )
                      )
                    );
                  }
                ) : Container();
              },
            )
          )
        ],
      )
    );
  }
}