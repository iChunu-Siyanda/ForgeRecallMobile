import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/hero_chat_card.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/kpi_grid.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/needs_attention_carousel.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/project_mastery_list.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/time_frame_picker.dart';
import 'package:forge_recall/features/projects/domain/entities/project_card_entity.dart';
import 'package:forge_recall/features/recall/domain/entities/recall_session_entity.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class AnalyticsPage extends StatefulWidget {
  final List<TopicEntity> topics;
  final List<ProjectCardEntity> projectCards;
  final List<RecallSessionEntity> recallSessions;

  const AnalyticsPage({
    super.key,
    required this.topics,
    required this.projectCards,
    required this.recallSessions,
  });

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int _selectedTimeframe = 0; // 0: 7 Days, 1: 30 Days, 2: All Time
  bool _showLineGraph = true; // Toggle between Accuracy (Line) & Volume (Bar)

  @override
  Widget build(BuildContext context) {
    // Derived Aggregations
    final totalDueTopics = widget.topics.where((t) {
      if (t.nextReviewAt == null) return false;
      return t.nextReviewAt!.isBefore(DateTime.now());
    }).length;

    final avgMastery = widget.topics.isEmpty
        ? 0.0
        : widget.topics.map((t) => t.masteryScore).reduce((a, b) => a + b) /
            widget.topics.length;

    final avgDifficulty = widget.topics.isEmpty
        ? 0.0
        : widget.topics
                .map((t) => t.cognitiveDifficulty)
                .reduce((a, b) => a + b) /
            widget.topics.length;

    final totalQuestions = widget.topics.fold<int>(
      0,
      (sum, item) => sum + item.questionCount,
    );

    final needsAttentionTopics = widget.topics
        .where((t) => t.masteryScore < 65.0)
        .toList()
      ..sort((a, b) => a.masteryScore.compareTo(b.masteryScore));

    return Scaffold(
      backgroundColor: AppColours.background,
      appBar: AppBar(
        backgroundColor: AppColours.background,
        elevation: 0,
        //scaffoldWillScaffold: false,
        title: const Text(
          'Analytics & Retention',
          style: TextStyle(
            color: AppColours.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune_rounded,
              color: AppColours.textSecondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeframe Segmented Control
            TimeframePicker(
              selectedIndex: _selectedTimeframe,
              onChanged: (index) =>
                  setState(() => _selectedTimeframe = index),
            ),
            const SizedBox(height: 16),

            // Hero Chart Card (Line/Bar Hybrid)
            HeroChartCard(
              sessions: widget.recallSessions,
              isLineGraph: _showLineGraph,
              onToggleGraph: () =>
                  setState(() => _showLineGraph = !_showLineGraph),
            ),
            const SizedBox(height: 20),

            // 2x2 Key Metric Grid
            KpiGrid(
              dueTopicsCount: totalDueTopics,
              averageMastery: avgMastery,
              avgDifficulty: avgDifficulty,
              totalQuestions: totalQuestions,
            ),
            const SizedBox(height: 24),

            // Project Mastery Section
            const Text(
              'Project Mastery',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColours.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ProjectMasteryList(projectCards: widget.projectCards),
            const SizedBox(height: 24),

            // Topics Needing Attention (Horizontal Swipe)
            if (needsAttentionTopics.isNotEmpty) ...[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Needs Attention',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColours.textPrimary,
                    ),
                  ),
                  Text(
                    'Low Mastery',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColours.crimson,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              NeedsAttentionCarousel(topics: needsAttentionTopics),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}
