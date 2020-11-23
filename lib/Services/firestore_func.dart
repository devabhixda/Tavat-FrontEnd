import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser(String name, String email, String dob, String gender) {
  return users.add({
    'name': name,
    'email': email,
    'dob': dob,
    'gender': gender
  })
  .then((value) => print("User Added"))
  .catchError((error) => print("Failed to add user: $error"));
}

Future<bool> getUser(String email) async {
  bool existing;
  await users.where('email', isEqualTo: email).get().then((value) => value.size == 0 ? existing = false : existing = true);
  return existing;
}