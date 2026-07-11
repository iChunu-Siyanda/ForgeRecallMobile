import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class RecommendedTopicsList extends StatelessWidget {
  final List<TopicEntity> topics;
  final Function(TopicEntity) onTopicTap;

  const RecommendedTopicsList({
    super.key,
    required this.topics,
    required this.onTopicTap,
  });

  @override
  Widget build(BuildContext context) {
    if (topics.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColours.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColours.glassBorder, width: 1.0),
        ),
        child: const Text(
          'No recommendations available right now.',
          style: TextStyle(
            color: AppColours.textMuted,
            fontSize: 14,
          ),
        ),
      );
    }

    // Set an explicit frame height for the horizontal layout belt
    return SizedBox(
      height: 145,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: topics.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final topic = topics[index];

          return Container(
            width: 240, // Standard modern horizontal card thickness aspect
            decoration: BoxDecoration(
              color: AppColours.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColours.glassBorder, width: 1.0),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => onTopicTap(topic),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header flag icon block
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColours.surfaceSecondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.auto_awesome, // Spark icon for recommendations
                              color: AppColours.violet,
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'RECOMMENDED',
                            style: TextStyle(
                              color: AppColours.violet,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Topic Title element
                      Expanded(
                        child: Text(
                          topic.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColours.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Meta details row
                      Row(
                        children: [
                          Icon(
                            Icons.quiz_outlined,
                            size: 13,
                            color: AppColours.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${topic.questionCount} Qs',
                            style: const TextStyle(
                              color: AppColours.textMuted,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.schedule_outlined,
                            size: 13,
                            color: AppColours.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${topic.estimatedReadTime}m',
                            style: const TextStyle(
                              color: AppColours.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
