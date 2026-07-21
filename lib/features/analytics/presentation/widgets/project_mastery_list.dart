import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/projects/domain/entities/project_card_entity.dart';

class ProjectMasteryList extends StatelessWidget {
  final List<ProjectCardEntity> projectCards;

  const ProjectMasteryList({super.key, required this.projectCards});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: projectCards.map((card) {
        final accent = card.getProjectAccent;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColours.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColours.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      card.project.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColours.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${card.masteryPercentage.toInt()}%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (card.masteryPercentage / 100).clamp(0.0, 1.0),
                  minHeight: 6,
                  backgroundColor: AppColours.surfaceSecondary,
                  valueColor: AlwaysStoppedAnimation<Color>(accent),
                ),
              ),
              const SizedBox(height: 10),

              // Meta Subtext Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${card.totalTopics} Topics • ${card.dueTopics} Due',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColours.textMuted,
                    ),
                  ),
                  Text(
                    'Studied ${card.lastStudied}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColours.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
