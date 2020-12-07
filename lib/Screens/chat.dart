import 'package:connect/Screens/ChatBox.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream chatRooms;
  String uid;
  Auth auth = new Auth();

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData ? (snapshot.data.documents.length > 0 ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ChatRoomsTile(
              userName: uid == snapshot.data.documents[index]['users'][1] ? snapshot.data.documents[index]['users'][0] : uid,
              chatRoomId: snapshot.data.documents[index]["chatRoomId"],
            );
          }) : Center(
          child: Text("You don't have any chats yet",
            style: GoogleFonts.ptSans(
              fontSize: 24
            ),
          )
        )
      ) : SpinKitDoubleBounce(
          color: cred,
          size: 30.0,
        );
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String me = prefs.getString('checkName');
    setState(() {
      uid = me;
    });
    auth.getUserChats(uid).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  $uid");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chat", 
          style: GoogleFonts.ptSans(
            fontSize: 24,
            color: Colors.black
          )
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: chatRoomsList(),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatBox(
            chatRoomId: chatRoomId,
            user: userName,
          )
        ));
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 0.1 * MediaQuery.of(context).size.width),
      leading: CircleAvatar(),
      title: Text(userName),
    );
  }
}
