import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/today/domain/entities/progress_params.dart';

class TodayProgressCard extends StatelessWidget {
  final ProgressParams progress; 

  const TodayProgressCard({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percentCompleteFraction = progress.percentCompleteFraction;
    final percentCompleteDisplay = progress.percentCompleteDisplay;

    return Container(
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColours.glassBorder, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  '$percentCompleteDisplay%',
                  style: const TextStyle(
                    color: AppColours.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Multi-hue layout track bar matching Google's native progress trackers
            Stack(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColours.surfaceSecondary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final targetWidth = percentCompleteFraction * constraints.maxWidth;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      height: 6,
                      width: targetWidth,
                      decoration: BoxDecoration(
                        gradient: AppColours.geminiGradient,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Evenly distributed metric slots using clean typography hierarchies
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  value: '${progress.topicsCompletedToday}',
                  label: 'Topics',
                ),
                _StatItem(
                  value: '${progress.questionsAnsweredToday}',
                  label: 'Questions',
                ),
                _StatItem(
                  value: '${progress.minutesStudiedToday}',
                  label: 'Minutes',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColours.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColours.textMuted,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
