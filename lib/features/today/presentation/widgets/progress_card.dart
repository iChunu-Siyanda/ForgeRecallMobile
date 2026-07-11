import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/today/presentation/widgets/progress_stat.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daily Goal',
                  style: TextStyle(
                    color: AppColours.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '0%',
                  style: TextStyle(
                    color: AppColours.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Custom Track containing the signature Gemini color scheme
            Stack(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColours.surfaceSecondary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  height: 6,
                  width: 0, // Dynamic percentage mapping binding context
                  decoration: BoxDecoration(
                    gradient: AppColours.geminiGradient,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProgressStat(
                  label: 'Topics',
                  value: '0',
                ),
                ProgressStat(
                  label: 'Questions',
                  value: '0',
                ),
                ProgressStat(
                  label: 'Minutes',
                  value: '0',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
