import 'package:flutter/material.dart';

class TopicEmptyState extends StatelessWidget {
  const TopicEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
        color: Colors.white.withValues(alpha: 0.03),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.psychology_alt_rounded,
            color: Color(0xFF8B5CF6),
            size: 48,
          ),

          SizedBox(height: 20),

          Text(
            'No Knowledge Forged Yet',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),

          SizedBox(height: 14),

          Text(
            'Topics become the cognitive foundation of your recall engine, adaptive drills, and mastery system.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF8B93A7),
              height: 1.7,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}