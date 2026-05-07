import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forge_recall/theme/app_colours.dart';
import 'package:forge_recall/theme/app_typography.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.obsidian,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.hexagon_rounded,
              size: 90,
              color: AppColours.electricBlue,
            )
                .animate()
                .scale(
                  duration: 1200.ms,
                  curve: Curves.easeOut,
                ),

            const SizedBox(height: 32),

            Text(
              'FORGERECALL',
              style: AppTypography.headlineLarge,
            )
                .animate()
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.4),

            const SizedBox(height: 12),

            Text(
              'MASTER THROUGH PRESSURE',
              style: AppTypography.body,
            )
                .animate(delay: 400.ms)
                .fadeIn(),
          ],
        ),
      ),
    );
  }
}