import 'package:flutter/material.dart';
import 'package:forge_recall/core/widgets/forge_card.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/core/theme/app_typography.dart';

class WeaknessAlertCard extends StatelessWidget {
  final String topic;
  final int strength;

  const WeaknessAlertCard({
    super.key,
    required this.topic,
    required this.strength,
  });

  @override
  Widget build(BuildContext context) {
    return ForgeCard(
      child: Row(
        children: [

          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: AppColours.crimson,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  topic,
                  style: AppTypography.headlineMedium.copyWith(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Recall Strength: $strength%",
                  style: AppTypography.body,
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right_rounded,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }
}