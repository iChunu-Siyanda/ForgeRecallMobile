import 'package:flutter/material.dart';
import 'package:forge_recall/theme/app_colours.dart';

class ForgeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ForgeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [
              AppColours.electricBlue,
              Color(0xFF306BFF),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColours.electricBlue.withValues(alpha:0.35),
              blurRadius: 18,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "ENTER THE FORGE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}