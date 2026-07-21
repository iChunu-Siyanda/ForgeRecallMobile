import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final double mastery;
  final int topics;
  final int due;
  final Color accentColor;
  final String lastStudied;
  final int daysSinceStudy;

  const ProjectCard({
    super.key,
    required this.title,
    required this.mastery,
    required this.topics,
    required this.due,
    required this.accentColor,
    required this.lastStudied,
    required this.daysSinceStudy,
  });

  @override
  Widget build(BuildContext context) {
    final masteryValue = mastery.clamp(0, 100);

    late Color studyColor;
    late IconData studyIcon;

    if (daysSinceStudy <= 1) {
      studyColor = AppColours.emerald;
      studyIcon = Icons.auto_awesome_rounded; 
    } else if (daysSinceStudy <= 3) {
      studyColor = AppColours.amber;
      studyIcon = Icons.schedule_rounded;
    } else {
      studyColor = AppColours.crimson;
      studyIcon = Icons.warning_amber_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(24), // Softer, modern rounding
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColours.glassBorder.withValues(alpha: 0.8),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER SECTION
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColours.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Chip for Topics Count
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColours.surfaceSecondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$topics Topics',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColours.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Sleek Minimalist Arrow Button
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: AppColours.surfaceSecondary.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: AppColours.textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // MASTERY SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mastery Progress',
                    style: TextStyle(
                      color: AppColours.textMuted,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${masteryValue.toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Gemini-themed Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      color: AppColours.surfaceSecondary,
                    ),
                    FractionallySizedBox(
                      widthFactor: masteryValue / 100,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: AppColours.geminiGradient, // Beautiful cosmic gradient flow
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              
              const Divider(color: AppColours.glassBorder, height: 1),
              
              const SizedBox(height: 14),

              // FOOTER STATUS CHIPS
              Row(
                children: [
                  // Review Status Chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: due > 0 
                          ? AppColours.crimson.withValues(alpha: 0.08) 
                          : AppColours.emerald.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      due > 0 ? '$due Reviews Due' : 'Up To Date',
                      style: TextStyle(
                        color: due > 0 ? AppColours.crimson : AppColours.emerald,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Study Recency indicator
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(studyIcon, size: 14, color: studyColor),
                      const SizedBox(width: 4),
                      Text(
                        lastStudied,
                        style: TextStyle(
                          color: studyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
