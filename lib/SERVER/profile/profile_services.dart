import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfileServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileData() async {
    final user = getCurrentUser();
    if (user == null) throw Exception("No user logged in");

    return await _firestore.collection('users').doc(user.uid).get();
  }

  Future<void> updateProfileData(Map<String, dynamic> updatedData) async {
    final user = getCurrentUser();
    if (user == null) throw Exception("No user logged in");

    await _firestore.collection('users').doc(user.uid).update(updatedData);
  }

  Future<String> uploadProfilePicture(File file) async {
    final user = getCurrentUser();
    if (user == null) throw Exception("No user logged in");

    final storageRef =
        _storage.ref().child('userProfilePics').child('${user.uid}.jpg');
    await storageRef.putFile(file);

    return await storageRef.getDownloadURL();
  }
}
