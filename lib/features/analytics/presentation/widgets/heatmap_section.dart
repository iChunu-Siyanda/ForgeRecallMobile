import 'package:flutter/material.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/glass_card.dart';

class HeatmapSection extends StatelessWidget {
  const HeatmapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MASTERY HEATMAP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(20, (index) {
              final opacity = (index + 1) / 20;

              return Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(
                    0xFF4D8DFF,
                  ).withValues(alpha: opacity * 0.8),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
