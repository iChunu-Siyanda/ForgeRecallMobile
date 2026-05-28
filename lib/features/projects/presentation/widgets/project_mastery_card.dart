import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

class ProjectMasteryCard extends StatelessWidget {
  final ProjectEntity project;
  const ProjectMasteryCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.07),
                Colors.white.withValues(alpha: 0.03),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Row(
                children: [
                  Icon(
                    Icons.psychology_alt_rounded,
                    color: Color(0xFF8B5CF6),
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Mastery Analytics',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                   Expanded(
                    child: _MasteryMetric(
                      title: 'Cognitive Strength',
                      value:
                          '${(project.masteryPercentage + 12).clamp(0, 100).toInt()}%',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _MasteryMetric(
                      title: 'Retention',
                      value:
                          '${(project.masteryPercentage - 8).clamp(0, 100).toInt()}%',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _MasteryMetric(
                      title: 'Recall Speed',
                      value: '2.8s',
                    ),
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
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withValues(alpha: 0.04),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
                        ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF8B93A7),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}  