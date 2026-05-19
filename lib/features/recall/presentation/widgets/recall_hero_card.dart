import 'package:flutter/material.dart';
import 'package:forge_recall/core/widgets/forge_card.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/core/theme/app_typography.dart';

class RecallHeroCard extends StatelessWidget {
  const RecallHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ForgeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Text(
            "TODAY'S TARGET",
            style: AppTypography.body.copyWith(
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  Text(
                    "84",
                    style: AppTypography.headlineLarge.copyWith(
                      fontSize: 54,
                    ),
                  ),
              
                  const SizedBox(height: 6),
              
                  Text(
                    "Questions Remaining",
                    style: AppTypography.body,
                  ),
                ],
              ),

              Container(
                width: 84,
                height: 84,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(
                    color: AppColours.electricBlue,
                    width: 6,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: AppColours.electricBlue.withValues(alpha: 0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),

                child: const Center(
                  child: Text(
                    "72%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            height: 10,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColours.steelGray,
            ),

            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.72,

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                  gradient: const LinearGradient(
                    colors: [
                      AppColours.electricBlue,
                      AppColours.emberOrange,
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            "Recall Stability Improving",
            style: AppTypography.body,
          ),
        ],
      ),
    );
  }
}

