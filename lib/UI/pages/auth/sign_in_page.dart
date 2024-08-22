import 'package:flutter/material.dart';
import 'package:profile_auth/SERVER/auth/auth_services.dart';
import 'package:profile_auth/UI/component/auth/auth_button.dart';
import 'package:profile_auth/UI/component/auth/auth_buttoned_txt.dart';
import 'package:profile_auth/UI/component/auth/auth_textfield.dart';
import 'package:profile_auth/UI/pages/auth/reset_pass_page.dart';

class SignInPage extends StatefulWidget {
  final Function()? onTap;
  const SignInPage({super.key, required this.onTap});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  final SignInService _signIn = SignInService();

  void resetPass() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ResetPassword();
        },
      ),
    );
  }

  void _handleSignIn() async {
    setState(() {
      isLoading = true;
    });

    await _signIn.signInUser(
      email: emailController.text,
      password: passwordController.text,
      onError: (message) {
        showErrorDialog(message);
        setState(() {
          isLoading = false;
        });
      },
      onSuccess: () {
        // Navigate to the next screen or do something on success
        if (mounted) {
          Navigator.pop(context);
        }
      },
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: [
                  const SizedBox(height: 100),

                  // Logo
                  const Icon(
                    Icons.android_rounded,
                    size: 100,
                  ),

                  const SizedBox(height: 40),

                  // Welcome back, you've been missed!
                  const Center(
                    child: Text(
                      'HELLO AGAIN',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Center(
                    child: Text(
                      'Welcome back you\'ve been missed!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Email TextField
                  AuthTextfield(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // Password TextField
                  AuthTextfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // Forgot Password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        AuthButtonedTxt(
                          onTap: resetPass,
                          text: 'Reset now',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Sign In Button
                  AuthButton(
                    text: "Sign In",
                    onTap: _handleSignIn,
                  ),

                  const SizedBox(height: 20),

                  // Not a member? Register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      AuthButtonedTxt(
                        onTap: widget.onTap,
                        text: 'Register now',
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
