import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:go_router/go_router.dart';
// import 'package:your_app/theme/app_colours.dart'; 

class TopicTile extends StatelessWidget {
  final TopicEntity topic;

  const TopicTile({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/topicsKnowledgePage', extra: topic),
      child: Container(
        // Slimmer horizontal interior padding, reduced vertical footprint
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColours.surface, // Pure clean white workspace card
          borderRadius: BorderRadius.circular(16), // Rounded but professional (not blocky)
          border: Border.all(
            color: AppColours.glassBorder,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Action / Mastery Visual Element
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    value: topic.masteryScore / 100,
                    strokeWidth: 3.5,
                    backgroundColor: AppColours.surfaceSecondary,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                  ),
                ),
                Text(
                  '${topic.masteryScore}%',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColours.electricBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),

            // Middle Column (Title + Minimal Inline Stats)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    topic.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColours.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // Sub-pill for difficulty
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColours.surfaceSecondary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          topic.cognitiveDifficulty.toString().split('.').last.toUpperCase(),
                          style: const TextStyle(
                            color: AppColours.textSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Inline Question Counter
                      Text(
                        '${topic.questionCount} Questions',
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
            
            // Right Arrow / Navigation indicator 
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColours.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
