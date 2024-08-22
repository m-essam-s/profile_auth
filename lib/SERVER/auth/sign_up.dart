import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUserDocument(
      User user, String firstName, String lastName, String email) async {
    await users.doc(user.uid).set({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "photoUrl":
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
      "role": "user",
      "createdAt": DateTime.now(),
      "updatedAt": DateTime.now(),
      "isEmailVerified": user.emailVerified,
      "isUserVerified": false,
      "gender": "",
      "dateOfBirth": "",
      "phoneNumber": "",
      "address": "",
      "city": "",
      "state": "",
      "country": "",
      "zipCode": "",
      "bio": "",
    });
  }

  Future<void> signUserUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required Function(String) onError,
    required Function onSuccess,
  }) async {
    if (password != confirmPassword) {
      onError('Passwords don\'t match!');
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;
      await createUserDocument(user, firstName, lastName, email);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'An error occurred');
    } catch (e) {
      onError('Failed to create user document: $e');
    }
  }
}
