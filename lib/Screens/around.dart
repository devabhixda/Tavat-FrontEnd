import 'package:connect/Models/user.dart';
import 'package:connect/Screens/ChatBox.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:connect/Screens/Person.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Around extends StatefulWidget {
  final location;
  final List<UserDetail> lst;
  Around({this.location, this.lst});
  @override
  _AroundState createState() => _AroundState();
}
class _AroundState extends State<Around> {

  String location, me;
  bool loading = true;

  void initState() {
    super.initState();
    setState(() {
      location = widget.location;
    });
    init();
    getAround();
  }

  Auth auth = new Auth();
  List<UserDetail> users = [], usersvir = [];

  getAround() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(location == "not set") {
      String loc = prefs.getString('location');
      if(loc != null) {
        setState(() {
          location = loc;
        });
      }
    }
    if(widget.lst == null) {
      List<UserDetail> lst;
      lst = await auth.getNearbyUsers(location);
      setAround(lst);
    } else {
      setAround(widget.lst);
    }
    setState(() {
      loading = false;
    });
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String u = prefs.getString('uid');
    setState(() {
      me = u;
    });
  }

  setAround(List<UserDetail> ulist) async {
    for(UserDetail u in ulist) {
      if(u.id != me) {
        if(u.virtual) {
          usersvir.add(u);
        } else {
          users.add(u);
        }
      }
    }
  }

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
              location == "not set" ? Center(
                child: Text("Please check in First",
                  style: GoogleFonts.ptSans(
                    fontSize: 24
                  ),
                )
              ) : !loading ? users.length == 0 ? Center(
                child: Text("There is no one around",
                  style: GoogleFonts.ptSans(
                    fontSize: 24
                  ),
                )
              ) : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0.05 * h),
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.1 * w),
                          leading: CircleAvatar(),
                          title: Text(users[index].name),
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
                                  onPressed: () => {
                                    sendMessage(users[index].id)
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBox(user: users[index].id,)))
                                  },
                                ),
                              ],
                            ),
                          ),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Person()))
                          },
                        );
                      }
                    ),
                  ),
                ],
              ) : SpinKitDoubleBounce(
                color: cred,
                size: 30.0,
              ),
              location == "not set" ? Center(
                child: Text("Please check in First",
                  style: GoogleFonts.ptSans(
                    fontSize: 24
                  ),
                )
              ) : !loading ? usersvir.length == 0 ? Center(
                child: Text("There is no one around",
                  style: GoogleFonts.ptSans(
                    fontSize: 24
                  ),
                )
              ) : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0.05 * h),
                      itemCount: usersvir.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.1 * w),
                          leading: CircleAvatar(),
                          title: Text(usersvir[index].name),
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
                                  onPressed: () => {
                                    sendMessage(usersvir[index].id)
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBox(user: users[index].id,)))
                                  },
                                ),
                              ],
                            ),
                          ),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Person()))
                          },
                        );
                      }
                    ),
                  ),
                ],
              ) : SpinKitDoubleBounce(
                color: cred,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
  sendMessage(String userName) async {
    String user = await auth.getName(userName);
    List<String> users = [await auth.getName(me), user];
    String chatRoomId = getChatRoomId(me, userName);
    auth.addChatRoom(users, chatRoomId);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ChatBox(
        chatRoomId: chatRoomId,
        user: user
      )
    ));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}