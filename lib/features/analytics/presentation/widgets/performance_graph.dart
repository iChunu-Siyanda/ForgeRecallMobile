import 'package:flutter/material.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/glass_card.dart';

class PerformanceGraph extends StatelessWidget {
  const PerformanceGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'FORGETTING CURVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                'Last 30 Days',
                style: TextStyle(
                  color: Color(0xFF8D93A6),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(12, (index) {
                final heights = [
                  40.0,
                  65.0,
                  90.0,
                  72.0,
                  110.0,
                  85.0,
                  130.0,
                  120.0,
                  150.0,
                  135.0,
                  165.0,
                  150.0,
                ];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    height: heights[index],
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          const Color(0xFF4D8DFF),
                          const Color(0xFF4D8DFF).withValues(alpha: 0.15),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
