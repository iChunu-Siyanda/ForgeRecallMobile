import 'package:flutter/material.dart';
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
    final masteryPercent = (topic.masteryScore * 100).clamp(0, 100);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                topic.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              /// Progress
              LinearProgressIndicator(
                value: masteryPercent / 100,
              ),

              const SizedBox(height: 8),

              Text(
                '${masteryPercent.toStringAsFixed(0)}% Mastery',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              const SizedBox(height: 16),

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
    return Chip(
      avatar: Icon(
        icon,
        size: 16,
      ),
      label: Text(label),
    );
  }
}
