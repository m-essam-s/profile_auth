import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profile_auth/UI/pages/auth/log_in_toggle.dart';
import 'package:profile_auth/UI/pages/home/home_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show a loading indicator while checking auth state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle errors in the stream
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          // User is logged in
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // User is NOT logged in
          return const LogInToggle();
        },
      ),
    );
  }
}
