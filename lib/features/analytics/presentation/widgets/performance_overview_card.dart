import 'package:flutter/material.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/glass_card.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/performance_metric.dart';

class PerformanceOverviewCard extends StatelessWidget {
  const PerformanceOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RECALL STABILITY',
            style: TextStyle(
              color: Color(0xFFB0B6C7),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                '81%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              SizedBox(width: 12),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  '+12% this week',
                  style: TextStyle(
                    color: Color(0xFF2ECC71),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              value: 0.81,
              minHeight: 14,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF4D8DFF)),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: const [
              PerformanceMetric(title: 'Avg Speed', value: '2.8s'),
              SizedBox(width: 14),
              PerformanceMetric(title: 'Sessions', value: '241'),
              SizedBox(width: 14),
              PerformanceMetric(title: 'Accuracy', value: '92%'),
            ],
          ),
        ],
      ),
    );
  }
}
