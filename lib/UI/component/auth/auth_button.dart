import 'package:flutter/material.dart';
import 'package:profile_auth/themes/theme_notifier.dart';
import 'package:provider/provider.dart';

class AuthButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const AuthButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          foregroundColor:
              themeNotifier.isDarkMode ? Colors.grey.shade300 : Colors.black,
          backgroundColor: null,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: themeNotifier.isDarkMode
                  ? Colors.grey.shade300
                  : Colors.grey.shade900,
              width: 1,
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
