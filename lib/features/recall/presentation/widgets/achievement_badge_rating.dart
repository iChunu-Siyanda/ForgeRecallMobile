import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class AchievementBadgeRating extends StatelessWidget {
  const AchievementBadgeRating({
    super.key,
    required this.performanceColor,
    required this.accuracy,
    required this.performance,
  });

  final Color performanceColor;
  final int accuracy;
  final String performance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: performanceColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              size: 72,
              color: performanceColor,
            ),
          ),
        ),
       
        const SizedBox(height: 24),
    
        Text(
          '$accuracy%',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColours.textPrimary,
            fontSize: 56,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
    
        const SizedBox(height: 6),
    
        Text(
          performance,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: performanceColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
    
        const SizedBox(height: 12),
    
        const Text(
          'Active recall session completed successfully.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColours.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
    
      ],
    );
  }
}
