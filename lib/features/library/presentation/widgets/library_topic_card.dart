import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class LibraryTopicCard extends StatelessWidget {
  final TopicEntity topic;
  final VoidCallback? onTap;

  const LibraryTopicCard({
    super.key,
    required this.topic,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final masteryPercent = (topic.masteryScore * 100).clamp(0.0, 100.0);

    return Container(
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColours.glassBorder, width: 1.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topic.title,
                style: const TextStyle(
                  color: AppColours.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              
              // Custom Gradient Tracking Line
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
                      final widthFraction = (masteryPercent / 100) * constraints.maxWidth;
                      return Container(
                        height: 6,
                        width: widthFraction,
                        decoration: BoxDecoration(
                          gradient: AppColours.geminiGradient,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${masteryPercent.toStringAsFixed(0)}% Mastery',
                style: const TextStyle(
                  color: AppColours.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.quiz_outlined,
                    label: '${topic.questionCount} Questions',
                  ),
                  _InfoChip(
                    icon: Icons.schedule_outlined,
                    label: '${topic.estimatedReadTime} mins',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColours.surfaceSecondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: AppColours.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColours.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
