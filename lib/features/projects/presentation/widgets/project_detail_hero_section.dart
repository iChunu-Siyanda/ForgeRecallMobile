import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/presentation/widgets/details_hero_metric.dart';
// import 'package:your_app/theme/app_colours.dart'; 

class ProjectDetailHeroSection extends StatelessWidget {
  const ProjectDetailHeroSection({super.key, required this.project});
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
      decoration: BoxDecoration(
        color: AppColours.surface, // Clean white surface
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gemini Spark Accent Icon
              Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  gradient: AppColours.geminiGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColours.surface,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              
              // Project Title Details Info Space
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ACTIVE WORKSPACE',
                      style: TextStyle(
                        color: AppColours.textMuted,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColours.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Refined Minimalist Circular Progress Tracker
              SizedBox(
                height: 64,
                width: 64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: CircularProgressIndicator(
                        value: project.masteryPercentage / 100,
                        strokeWidth: 5,
                        backgroundColor: AppColours.surfaceSecondary,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColours.electricBlue,
                        ),
                      ),
                    ),
                    Text(
                      '${project.masteryPercentage.toInt()}%',
                      style: const TextStyle(
                        color: AppColours.electricBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColours.glassBorder, height: 1),
          ),

          Text(
            project.description,
            style: const TextStyle(
              color: AppColours.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 20),

          // Horizontal Metrics Panel Rows
          Row(
            children: [
              Expanded(
                child: DetailsHeroMetric(
                  title: 'Topics',
                  value: '${project.totalTopics}',
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: DetailsHeroMetric(
                  title: 'Recall Strength',
                  value: '84%',
                ),
              ),
              const SizedBox(width: 12),
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
    );
  }
}
