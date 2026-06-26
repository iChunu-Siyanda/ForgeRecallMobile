import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/core/theme/app_typography.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Good Morning, Siyanda",
                style: AppTypography.headlineMedium,
              ),

              const SizedBox(height: 8),

              Text(
                "12 Recall Drills Due",
                style: AppTypography.body,
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColours.surfaceSecondary,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}