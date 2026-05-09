import 'package:flutter/material.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/analytics_header.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/cognitive_performance.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/heatmap_section.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/performance_graph.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/performance_overview_card.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/strengths_weaknesses.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // HEADER
              const AnalyticsHeader(),
              const SizedBox(height: 30),

              // PERFORMANCE OVERVIEW CARD
              const PerformanceOverviewCard(),
              const SizedBox(height: 28),

              // COGNITIVE PERFORMANCE
              const CognitivePerformanceCard(
                title: 'COGNITIVE PERFORMANCE',
                insights: [
                  'Your recall speed has improved by 15% compared to last week.',
                  'You have maintained a consistent study streak for 10 days.',
                  'Your average recall accuracy is at 92%, which is excellent!',
                ],
              ),
              const SizedBox(height: 28),

              // PERFORMANCE GRAPH
              const PerformanceGraph(),
              const SizedBox(height: 28),

              // STRENGTHS & WEAKNESSES
              const StrengthsWeaknesses(),
              const SizedBox(height: 28),

              // HEATMAP SECTION
              const HeatmapSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
