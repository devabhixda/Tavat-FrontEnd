import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/Services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connect/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {

  Auth auth = new Auth();
  DocumentSnapshot snapshot;
  bool edit = false;
  String user;
  String interests, about;
  File _imageFile;
  final picker = ImagePicker();

  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    setState(() {
      user = uid;
    });
    DocumentSnapshot snap = await auth.getUserProfile(uid);
    setState(() {
      snapshot = snap;
      interests = snap["interests"];
      about = snap["about"];
    });
    print(snapshot["pfp"].length+1);
  }

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
      body: snapshot != null ? SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0.5 * h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot["pfp"].length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: w,
                    child: Image(image: NetworkImage(snapshot["pfp"][index]), fit: BoxFit.fill)
                  );
                },
              )
            ),
            Container(
              width: w,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(snapshot["name"]+", ", 
                        style: GoogleFonts.ptSans(
                          fontSize: 28,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      Text((DateTime.now().year - int.parse(snapshot["dob"].split("-")[0])).toString(), 
                        style: GoogleFonts.ptSans(
                          fontSize: 28,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                  edit ? TextField(
                    onChanged: (value) {
                      setState(() {
                        interests = value;
                      });
                    },
                  ) : Text(interests,
                    style: GoogleFonts.ptSans(
                      fontSize: 22,
                      color: cred
                    ),
                  ),
                  SizedBox(height: 10),
                  edit ? TextField(
                    onChanged: (value) {
                      setState(() {
                        about = value;
                      });
                    },
                  ) : Text(about,
                    style: GoogleFonts.ptSans(
                      fontSize: 22,
                      color: Colors.grey
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ) : SpinKitDoubleBounce(
        color: cred,
        size: 30.0,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 0.02 * h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: cred,
              child: IconButton(
                icon: Icon(edit ? Icons.done : Icons.edit, color: Colors.white),
                onPressed: () => {
                  setState(() {
                    edit = !edit;
                  }),
                  auth.updateProfile(user, about, interests)
                },
              ),
            ),
            CircleAvatar(
              backgroundColor: cred,
              child: IconButton(
                icon: Icon(Icons.add_a_photo, color: Colors.white),
                onPressed: () => {
                  pickImage()
                },
              )
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

  pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
    await auth.uploadImage(_imageFile, user);
    await getUserInfo();
  }
}