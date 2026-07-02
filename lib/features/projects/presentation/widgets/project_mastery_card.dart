import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
// import 'package:your_app/theme/app_colours.dart'; 

class ProjectMasteryCard extends StatelessWidget {
  final ProjectEntity project;
  const ProjectMasteryCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColours.glassBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.psychology_alt_rounded,
                color: AppColours.violet, // Shifted away from bright deepPurple
                size: 22,
              ),
              SizedBox(width: 10),
              Text(
                'Mastery Analytics',
                style: TextStyle(
                  color: AppColours.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _MasteryMetric(
                  title: 'Cognitive Strength',
                  value: '${(project.masteryPercentage + 12).clamp(0, 100).toInt()}%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MasteryMetric(
                  title: 'Retention',
                  value: '${(project.masteryPercentage - 8).clamp(0, 100).toInt()}%',
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: _MasteryMetric(
                  title: 'Recall Speed',
                  value: '2.8s',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MasteryMetric extends StatelessWidget {
  final String title;
  final String value;

  const _MasteryMetric({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColours.background, // Uses light workspace grey tint as sub-tiles
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColours.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColours.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
