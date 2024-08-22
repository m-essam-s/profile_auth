import 'package:flutter/material.dart';
import 'package:profile_auth/SERVER/auth/auth_services.dart';
import 'package:profile_auth/UI/component/auth/auth_button.dart';
import 'package:profile_auth/UI/component/auth/auth_textfield.dart';
import 'package:profile_auth/themes/theme_notifier.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();
  bool isLoading = false;

  final ResetPasswordService _resetPasswordService = ResetPasswordService();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    setState(() {
      isLoading = true;
    });

    await _resetPasswordService.sendPasswordResetEmail(
      email: emailController.text,
      onError: (message) {
        _showSnackBar(message);
        setState(() {
          isLoading = false;
        });
      },
      onSuccess: (message) {
        _showDialog(message);
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Enter your email to receive a password reset link.',
                      style: TextStyle(
                          fontSize: 18,
                          color: themeNotifier.isDarkMode
                              ? Colors.grey.shade300
                              : Colors.grey.shade900),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    AuthTextfield(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      text: 'Reset Password',
                      onTap: _handleReset,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
