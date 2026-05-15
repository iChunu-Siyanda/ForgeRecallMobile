import 'package:flutter/material.dart';
import 'package:forge_recall/core/widgets/forge_card.dart';
import 'package:forge_recall/theme/app_typography.dart';


class StatTile extends StatelessWidget {
  final String value;
  final String label;

  const StatTile({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ForgeCard(
      padding: const EdgeInsets.symmetric(
        vertical: 22,
      ),
      child: Column(
        children: [

          Text(
            value,
            style: AppTypography.headlineMedium,
          ),

          const SizedBox(height: 10),

          Text(
            label,
            style: AppTypography.body,
          ),
        ],
      ),
    );
  }
}