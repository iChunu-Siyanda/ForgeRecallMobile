import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/presentation/widgets/details_hero_metric.dart';

class ProjectDetailHeroSection extends StatelessWidget {
  const ProjectDetailHeroSection({super.key, required this.project});
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7C3AED),
                          Color(0xFF4F46E5),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    height: 92,
                    width: 92,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                         SizedBox(
                          height: 92,
                          width: 92,
                          child: CircularProgressIndicator(
                            value: project.masteryPercentage / 100,
                            strokeWidth: 8,
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.08),
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xFF8B5CF6),
                            ),
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${project.masteryPercentage.toInt()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                              ),
                            ),
                            const Text(
                              'Mastery',
                              style: TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),  
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Text(
                project.description,
                style: const TextStyle(
                  color: Color(0xFFB6C2D1),
                  fontSize: 14,
                  height: 1.7,
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: DetailsHeroMetric(
                      title: 'Topics',
                      value: '${project.totalTopics}',
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: DetailsHeroMetric(
                      title: 'Recall Strength',
                      value: '84%',
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: DetailsHeroMetric(
                      title: 'Pressure',
                      value: 'High',
                    ),
                  ),
                ],
              ),      
            ],
          ),
        )
      ),
    );
  }
}