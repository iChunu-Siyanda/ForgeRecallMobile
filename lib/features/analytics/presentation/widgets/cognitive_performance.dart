import 'package:flutter/material.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/insight_card.dart';

class CognitivePerformanceCard extends StatelessWidget {
  final String title;
  final List<String> insights;

  const CognitivePerformanceCard({
    super.key,
    required this.title,
    required this.insights,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),

        const SizedBox(height: 18),

        const Row(
          children: [
            InsightCard(
              title: 'Mental Endurance',
              value: 'HIGH',
              subtitle: 'Consistent under pressure',
              icon: Icons.bolt_rounded,
              accent: Color(0xFFFF7A00),
            ),
            SizedBox(width: 16),
            InsightCard(
              title: 'Retention',
              value: '84%',
              subtitle: 'Stable memory formation',
              icon: Icons.memory_rounded,
              accent: Color(0xFF4D8DFF),
            ),
          ],
        ),
      ],
    );
  }
}
