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

  @override
  void initState() {
    super.initState();
    getUserInfogetChats();
  }

  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String me = prefs.getString('checkName');
    setState(() {
      uid = me;
    });
    String user = prefs.getString('uid');
    auth.getUserChats(user).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
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

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData ? (snapshot.data.documents.length > 0 ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ChatRoomsTile(
              userName: uid == snapshot.data.documents[index]['users'][1] ? snapshot.data.documents[index]['users'][0] : snapshot.data.documents[index]['users'][1],
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
