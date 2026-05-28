import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_metric.dart';

class TopicTile extends StatelessWidget {
  final String title;
  final int mastery;
  final int questions;
  final String difficulty;

  const TopicTile({
    super.key,
    required this.title,
    required this.mastery,
    required this.questions,
    required this.difficulty,
  });

    @override
    Widget build(BuildContext context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                    Colors.white.withValues(alpha: 0.06),
                    Colors.white.withValues(alpha: 0.03),
                  ],
                ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        height: 1.3,
                      ),
                    ),
                  ),  
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color:
                          Colors.deepPurple.withValues(alpha: 0.15),
                    ),
                    child: Text(
                      difficulty,
                      style: const TextStyle(
                        color: Color(0xFFC4B5FD),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),  

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: TopicMetric(
                      title: 'Mastery',
                      value: '$mastery%',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TopicMetric(
                      title: 'Questions',
                      value: '$questions',
                    ),
                  ),
                  const SizedBox(width: 12),
                   const Expanded(
                    child: TopicMetric(
                      title: 'Pressure',
                      value: 'Stable',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: LinearProgressIndicator(
                  value: mastery / 100,
                  minHeight: 10,
                  backgroundColor:
                      Colors.white.withValues(alpha: 0.05),
                  valueColor: const AlwaysStoppedAnimation(
                    Color(0xFF8B5CF6),
                  ),
                ),
              ),

              const SizedBox(height: 20),

                  Row(
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    color: Color(0xFF8B5CF6),
                    size: 18,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    'Adaptive Recall Ready',
                    style: TextStyle(
                      color: Color(0xFFB6C2D1),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}  