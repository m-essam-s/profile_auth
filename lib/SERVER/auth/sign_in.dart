import 'package:firebase_auth/firebase_auth.dart';

class SignIn {
  Future<void> signInUser({
    required String email,
    required String password,
    required Function(String) onError,
    required Function onSuccess,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      onError('Please fill in both email and password fields.');
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'An error occurred during sign-in.');
    }
  }
}
