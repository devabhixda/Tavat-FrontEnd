import 'package:connect/consts.dart';
import 'package:flutter/material.dart';

class chat extends StatefulWidget {
  @override
  _chatState createState() => _chatState();
}
class _chatState extends State<chat> {
  double h,w;
  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgrey,
      appBar: AppBar(
        backgroundColor: cred,
        title: Row(
          children: [
            CircleAvatar(),
            SizedBox(
              width: 10,
            ),
            Center(child: Text("Person"),),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              Container(
                height: 0.8 * h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  )
                ],
              ),
            ],
          )
        )
      )
    );
  }
}