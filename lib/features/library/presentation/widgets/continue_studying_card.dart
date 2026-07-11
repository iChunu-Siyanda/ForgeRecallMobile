import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class ContinueStudyingCard extends StatelessWidget {
  const ContinueStudyingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColours.glassBorder, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Beautiful Gemini Gradient Icon Frame
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColours.geminiGradient,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Continue Studying',
                    style: TextStyle(
                      color: AppColours.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pick up where you left off.',
                    style: TextStyle(
                      color: AppColours.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Custom Outlined/Filled Modern Button
            TextButton(
              onPressed: () {
                // Handle Action
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColours.surfaceSecondary,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text(
                'Resume',
                style: TextStyle(
                  color: AppColours.electricBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
