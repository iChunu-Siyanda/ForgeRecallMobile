import 'package:flutter/material.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/glass_card.dart';

class TopicPerformanceCard extends StatelessWidget {
  final String title;
  final List<String> topics;
  final Color accent;

  const TopicPerformanceCard({
    super.key, 
    required this.title,
    required this.topics,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 22),
          ...topics.map(
            (topic) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    topic,
                    style: const TextStyle(
                      color: Color(0xFFE6EAF2),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
