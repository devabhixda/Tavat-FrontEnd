import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser(String name, String phone, String email) {
  return users.add({
    'name': name,
    'phone': phone,
    'email': email 
  })
  .then((value) => print("User Added"))
  .catchError((error) => print("Failed to add user: $error"));
}

Future<bool> getUserByPhone(String phone) async {
  bool existing;
  await users.where('phone', isEqualTo: phone).get().then((value) => value.size == 0 ? existing = false : existing = true);
  return existing;
}

Future<bool> getUserByEmail(String email) async {
  bool existing;
  await users.where('email', isEqualTo: email).get().then((value) => value.size == 0 ? existing = false : existing = true);
  return existing;
}