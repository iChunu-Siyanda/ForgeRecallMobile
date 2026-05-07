import 'package:flutter/material.dart';
import 'package:forge_recall/feautures/profile/presentation/widgets/profile_glass_card.dart';

class PerformanceTile extends StatelessWidget {
  final String title;
  final String value;
  final Color accent;
  final IconData icon;

  const PerformanceTile({
    super.key, 
    required this.title,
    required this.value,
    required this.accent,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: accent.withValues(alpha: 0.12),
            ),
            child: Icon(
              icon,
              color: accent,
            ),
          ),

          const SizedBox(height: 22),

          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFFB0B6C7),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
