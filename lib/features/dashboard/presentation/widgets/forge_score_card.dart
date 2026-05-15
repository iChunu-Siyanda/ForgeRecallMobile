import 'package:flutter/material.dart';
import 'package:forge_recall/core/widgets/forge_card.dart';
import 'package:forge_recall/theme/app_colours.dart';
import 'package:forge_recall/theme/app_typography.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ForgeScoreCard extends StatelessWidget {
  const ForgeScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ForgeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DAILY FORGE SCORE",
            style: AppTypography.body.copyWith(letterSpacing: 1.5),
          ),

          const SizedBox(height: 24),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "84%",
                style: AppTypography.headlineLarge.copyWith(fontSize: 48),
              ),

              const SizedBox(width: 12),

              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text("Mastery", style: AppTypography.body),
              ),
            ],
          ),

          const SizedBox(height: 24),

          LinearPercentIndicator(
            lineHeight: 10,
            percent: 0.84,
            animation: true,
            barRadius: const Radius.circular(30),
            progressColor: AppColours.electricBlue,
            backgroundColor: AppColours.steelGray,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
