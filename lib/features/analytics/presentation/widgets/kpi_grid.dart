import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class KpiGrid extends StatelessWidget {
  final int dueTopicsCount;
  final double averageMastery;
  final double avgDifficulty;
  final int totalQuestions;

  const KpiGrid({
    super.key,
    required this.dueTopicsCount,
    required this.averageMastery,
    required this.avgDifficulty,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        _KpiTile(
          title: 'Due for Review',
          value: '$dueTopicsCount Topics',
          icon: Icons.alarm_rounded,
          accentColor: AppColours.amber,
        ),
        _KpiTile(
          title: 'Avg Mastery',
          value: '${averageMastery.toStringAsFixed(1)}%',
          icon: Icons.military_tech_rounded,
          accentColor: AppColours.electricBlue,
        ),
        _KpiTile(
          title: 'Cognitive Load',
          value: '${avgDifficulty.toStringAsFixed(1)} / 5.0',
          icon: Icons.psychology_rounded,
          accentColor: AppColours.violet,
        ),
        _KpiTile(
          title: 'Questions Cleared',
          value: '$totalQuestions',
          icon: Icons.check_circle_outline_rounded,
          accentColor: AppColours.emerald,
        ),
      ],
    );
  }
}

class _KpiTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;

  const _KpiTile({
    required this.title,
    required this.value,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColours.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColours.textMuted,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 14, color: accentColor),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColours.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
