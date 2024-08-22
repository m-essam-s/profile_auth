import 'package:flutter/material.dart';
import 'package:profile_auth/SERVER/auth/auth_services.dart';
import 'package:profile_auth/UI/component/auth/auth_button.dart';
import 'package:profile_auth/UI/component/auth/auth_buttoned_txt.dart';
import 'package:profile_auth/UI/component/auth/auth_textfield.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isLoading = false;

  final SignUpService _signUp = SignUpService();

  void _handleSignUp() async {
    setState(() {
      isLoading = true;
    });

    await _signUp.signUserUp(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      onError: (message) {
        showErrorDialog(message);
        setState(() {
          isLoading = false;
        });
      },
      onSuccess: () {
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
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 100),
                  const Center(
                    child: Text(
                      'HELLO THERE',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Let\'s create an account for you!',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  AuthTextfield(
                    controller: _firstNameController,
                    hintText: 'First Name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  AuthTextfield(
                    controller: _lastNameController,
                    hintText: 'Last Name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  AuthTextfield(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  AuthTextfield(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  AuthTextfield(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AuthButton(
                    text: "Sign Up",
                    onTap: _handleSignUp,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(width: 4),
                      AuthButtonedTxt(
                        onTap: widget.onTap,
                        text: 'Login now',
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
