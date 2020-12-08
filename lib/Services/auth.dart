import 'package:connect/Models/user.dart';
import 'package:connect/Screens/Onboarding/signup.dart';
import 'package:connect/Screens/base.dart';
import 'package:connect/Services/firestore_func.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Auth{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User> get authStateChanges => auth.authStateChanges();
  String _verificationId;
  GoogleSignIn googleSignIn = GoogleSignIn();
  User user;

  createAccount(String email, String password, String name, String dob, String gender) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      ).then((cred) async {
        _firestore.collection('users').doc(cred.user.uid).set({
          'email': email,
          'name': name,
          'dob': dob,
          'gender': gender
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('uid', cred.user.uid);
        user = auth.currentUser;
        return cred;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signIn(String email, String password) async {
    UserCredential userCredential;
    try {
       userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      user = auth.currentUser;
    } catch (e) {
      print(e);
    }
    return userCredential != null;
  }

  Future<void> verifyPhone(String phone, BuildContext context) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this._verificationId = verId;
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phone,
          codeAutoRetrievalTimeout: (String verId) {
            this._verificationId = verId;
          },
          codeSent: smsOTPSent, 
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            await onVerify(phone, context);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (error) {
      print(error);
    }
  }

  Future<void> verifyEmail(String email, BuildContext context) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: "abcd1234"
    );
    try {
      await userCredential.user.sendEmailVerification();
    } catch (e) {
      print(e.message);
    }
  }

  verifyOtp(String phone, String otp, BuildContext context) async{
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId, 
      smsCode: otp
    );
    try {
      await auth.signInWithCredential(phoneAuthCredential);
      await onVerify(phone, context);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = auth.currentUser;
      assert(user.uid == currentUser.uid);
      print("signInWithGoogle succeeded");
      bool exists;
      await getUser(user.email).then((value) => exists = value);
      return exists;
    }
    return null;
  }

  onVerify(String phone, BuildContext context) async {
    bool exists;
    await getUser(phone).then((value) => exists = value);
    Navigator.push(context, MaterialPageRoute(builder: (context) => exists ? Base() : signup()));
  }

  checkIn(String uid, String location, String checkName, bool virtual) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('checkIn');
    callable.call(
      <String, dynamic>{
        'uid': uid,
        'location': location,
        'checkName': checkName,
        'virtual': virtual
      },
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location);
    prefs.setString('checkName', checkName);
  }

  getNearbyUsers(String location) async {
    List<UserDetail> lst = [];
    QuerySnapshot qs =  await _firestore.collection('users').where('location', isEqualTo: location).get();
    for(int i=0;i<qs.docs.length;i++) {
      String name;
      await _firestore.collection('users').doc(qs.docs.elementAt(i).id).get().then((val) => {
        name = val.data()['checkName']
      });
      UserDetail user = new UserDetail(qs.docs.elementAt(i).id, name);
      lst.add(user);  
    }
    return lst;
  }

  addChatRoom(chatRoom, chatRoomId) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('addChatRoom');
    callable.call(
      <String, dynamic>{
        "chatRoom": chatRoom,
        "chatRoomId": chatRoomId
      },
    );
  }

  getChats(String chatRoomId) async {
    return _firestore.collection("chatRoom").doc(chatRoomId).collection("chats").orderBy('time').snapshots();
  }

  addMessage(String chatRoomId, String sendBy, String message) async{
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('addMessage');
    callable.call(
      <String, dynamic>{
        "sendBy": sendBy,
        "message": message,
        "time": DateTime.now().millisecondsSinceEpoch.toString(),
        "chatRoomId": chatRoomId
      },
    );
    HttpsCallable callable1 = FirebaseFunctions.instance.httpsCallable('updated');
    callable1.call(
      <String, dynamic>{
        "updatedAt": DateTime.now().toString(),
        "chatRoomId": chatRoomId
      },
    );
  }

  getUserChats(String itIsMyName) async {
    return _firestore.collection("chatRoom").where('users', arrayContains: itIsMyName).snapshots();
  }

  Future<String> getName(String uid) async{
    String name;
    await _firestore.collection("users").doc(uid).get().then((val) => {
      name = val.data()['checkName']
    });
    return name;
  }
}