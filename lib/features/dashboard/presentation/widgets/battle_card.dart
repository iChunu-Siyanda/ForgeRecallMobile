import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/core/theme/app_typography.dart';
import 'package:forge_recall/core/widgets/forge_card.dart';

class BattleCard extends StatelessWidget {
  final String title;
  final int drills;
  final String duration;
  final String difficulty;

  const BattleCard({
    super.key,
    required this.title,
    required this.drills,
    required this.duration,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return ForgeCard(
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title.toUpperCase(),
                  style: AppTypography.headlineMedium.copyWith(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "$drills Recall Drills",
                  style: AppTypography.body,
                ),

                const SizedBox(height: 6),

                Text(
                  duration,
                  style: AppTypography.body,
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColours.amber.withValues(alpha:0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              difficulty,
              style: const TextStyle(
                color: AppColours.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}