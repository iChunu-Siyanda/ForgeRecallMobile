import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forge_recall/theme/app_colours.dart';
import 'package:forge_recall/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    //context.go('/auth');
    context.go('/dashboard');
  }

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