import 'package:flutter/material.dart';

class TopicSectionHeader extends StatelessWidget {
  const TopicSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Knowledge Architecture',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: -0.5,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Transform information into recall-ready mastery',
              style: TextStyle(
                color: Color(0xFF8B93A7),
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),

         Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.deepPurple.withValues(alpha: 0.12),
          ),
          child: const Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFF8B5CF6),
          ),
        ),
      ],
    );
  }
}