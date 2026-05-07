import 'package:flutter/material.dart';
import 'package:forge_recall/feautures/analytics/presentation/widgets/topic_performance_card.dart';

class StrengthsWeaknesses extends StatelessWidget {
  const StrengthsWeaknesses({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: TopicPerformanceCard(
            title: 'TOP STRENGTHS',
            topics: [
              'Derivatives',
              'Firebase Auth',
              'State Management',
              'Kinematics',
            ],
            accent: Color(0xFF2ECC71),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TopicPerformanceCard(
            title: 'TOP FAILURES',
            topics: [
              'Integration by Parts',
              'Riverpod Lifecycle',
              'Heat Transfer',
              'Matrices',
            ],
            accent: Color(0xFFFF4D5A),
          ),
        ),
      ],
    );
  }
}
