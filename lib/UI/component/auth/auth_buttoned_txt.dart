import 'package:flutter/material.dart';

class AuthButtonedTxt extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const AuthButtonedTxt({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
