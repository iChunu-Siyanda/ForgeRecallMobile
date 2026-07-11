import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class TodayProgressCard extends StatelessWidget {
  final dynamic progress; // Replaced placeholder with your parent dashboard data map

  const TodayProgressCard({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    // Handle calculations safely to avoid dividing by zero if metrics are initialization blanks
    final totalPlanned = progress.totalPlannedTasks ?? 1;
    final totalCompleted = progress.completedTasksCount ?? 0;
    
    // Safely structure precision values mapped cleanly between 0.0 and 1.0
    final percentCompleteFraction = (totalCompleted / totalPlanned).clamp(0.0, 1.0);
    final percentCompleteDisplay = (percentCompleteFraction * 100).toStringAsFixed(0);

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
                  value: '${progress.studiedTopicsCount ?? 0}',
                  label: 'Topics',
                ),
                _StatItem(
                  value: '${progress.reviewedQuestionsCount ?? 0}',
                  label: 'Questions',
                ),
                _StatItem(
                  value: '${progress.totalStudyMinutes ?? 0}',
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
