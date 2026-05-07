import 'package:flutter/material.dart';
import 'package:forge_recall/feautures/recall/presentation/widgets/metric_card.dart';
import 'package:forge_recall/theme/app_typography.dart';

class RecallSessionStats extends StatelessWidget {
  const RecallSessionStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "SESSION METRICS",
          style: AppTypography.body.copyWith(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        const Row(
          children: [
            Expanded(
              child: MetricCard(value: "2.8s", label: "Response"),
            ),

            SizedBox(width: 14),

            Expanded(
              child: MetricCard(value: "91%", label: "Accuracy"),
            ),
          ],
        ),

        const SizedBox(height: 14),

        const Row(
          children: [
            Expanded(
              child: MetricCard(value: "17", label: "Streak"),
            ),

            SizedBox(width: 14),

            Expanded(
              child: MetricCard(value: "4h", label: "Focus"),
            ),
          ],
        ),
      ],
    );
  }
}
