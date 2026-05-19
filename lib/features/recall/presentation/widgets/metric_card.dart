import 'package:flutter/material.dart';
import 'package:forge_recall/core/widgets/forge_card.dart';
import 'package:forge_recall/core/theme/app_typography.dart';

class MetricCard extends StatelessWidget {
  final String value;
  final String label;

  const MetricCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return ForgeCard(
      padding: const EdgeInsets.symmetric(vertical: 24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: AppTypography.headlineMedium),

          const SizedBox(height: 10),

          Text(label, style: AppTypography.body),
        ],
      ),
    );
  }
}
