import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/Services/auth.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_offline/flutter_offline.dart';

class ChatBox extends StatefulWidget {
  final String chatRoomId, user;
  ChatBox({this.chatRoomId, this.user});
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  Auth auth = new Auth();
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  String uid;
  final encrypter = Encrypter(AES(Key.fromUtf8('my 32 length key................')));

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    Stream<QuerySnapshot> temp = await auth.getChats(widget.chatRoomId);
    setState(() {
      chats = temp;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String me = prefs.getString('uid');
    setState(() {
      uid = me;
    });
  }

  double w,h;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cred,
        title: Row(
          children: [
            CircleAvatar(),
            SizedBox(
              width: 10,
            ),
            Center(child: Text(widget.user),),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: null,
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                if (connectivity == ConnectivityResult.none) {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 0.03 * h),
                    child: Text("You are offline",
                      style: GoogleFonts.ptSans(
                        fontSize: 16
                      ),
                    )
                  );
                } else {
                  return child;
                }
              },
              builder: (BuildContext context) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 0.01 * h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.8 * w,
                        height: 0.06 * h,
                        child: new Theme(
                          data: new ThemeData(
                            primaryColor: cred,
                            primaryColorDark: cred,
                          ),
                          child: TextField(
                            controller: messageEditingController,
                            textAlignVertical: TextAlignVertical.bottom,
                            cursorColor: cred,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: cred),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: cred)
                              ),
                              hintText: "Type a message",
                              suffixIcon: Icon(Icons.camera, color: cred),
                            ),
                          ),
                        )
                      ),
                      IconButton(
                        icon: Icon(Icons.send, color: cred, size: 32),
                        onPressed: () => {
                          addMessage()
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget chatMessages(){
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return MessageTile(
              message: encrypter.decrypt(Encrypted.fromBase64(snapshot.data.documents[index]["message"]), iv: IV.fromLength(16)),
              sendByMe: uid == snapshot.data.documents[index]["sendBy"],
            );
          }
        ) : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      final message = encrypter.encrypt(messageEditingController.text, iv: IV.fromLength(16));
      auth.addMessage(widget.chatRoomId, uid, message.base64);
      setState(() {
        messageEditingController.text = "";
      });
    }
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: sendByMe ? Colors.blue : Colors.white
        ),
        child: Text(
          message,
          textAlign: TextAlign.start,
          style: GoogleFonts.ptSans(
            fontSize: 20,
            color: sendByMe ? Colors.white : Colors.blue
          )
        ),
      ),
    );
  }
}