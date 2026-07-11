import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class TodayHeroCard extends StatelessWidget {
  const TodayHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColours.surfaceSecondary,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColours.glassBorder, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ready to learn?',
              style: TextStyle(
                color: AppColours.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Continue building your mastery today.',
              style: TextStyle(
                color: AppColours.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
