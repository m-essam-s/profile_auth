import 'package:flutter/material.dart';
import 'package:profile_auth/themes/theme_notifier.dart';
import 'package:provider/provider.dart';

class AuthTextfield extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const AuthTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: themeNotifier.isDarkMode
                  ? Colors.grey.shade300
                  : Colors.grey.shade900, // Use Colors instead of Icons
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15), // Apply border radius here
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15), // Maintain same radius
          ),
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
