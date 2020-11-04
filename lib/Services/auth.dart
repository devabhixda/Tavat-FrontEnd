import 'package:connect/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Auth{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User> get authStateChanges => auth.authStateChanges();
  String _verificationId;

  createAccount(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
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

  signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  verifyPhone(String phone, BuildContext context) async{
    await auth.verifyPhoneNumber(
      phoneNumber: '+91' + phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print("codeAutoRetrievalTimeout");
      },
      verificationFailed: (FirebaseAuthException e) {
        
      },
      codeSent: (String verificationId, int resendToken) {
        _verificationId = verificationId;
      },
    );
  }

  verifyOtp(String otp) async{
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId, 
      smsCode: otp
    );
    try {
      await auth.signInWithCredential(phoneAuthCredential);
    } catch (e) {
      print(e);
    }
  }
}