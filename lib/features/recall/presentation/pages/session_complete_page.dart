import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/recall/domain/entities/complete_recall_stats.dart';
import 'package:forge_recall/features/recall/presentation/widgets/achievement_badge_rating.dart';
import 'package:forge_recall/features/recall/presentation/widgets/stats_and_ai_panel.dart';
import 'package:go_router/go_router.dart';

class SessionCompletePage extends StatelessWidget {
  final int totalQuestions;
  final int easyCount;
  final int partialCount;
  final int forgotCount;

  const SessionCompletePage({
    super.key,
    required this.totalQuestions,
    required this.easyCount,
    required this.partialCount,
    required this.forgotCount,
  });

  @override
  Widget build(BuildContext context) {
    final result = CompleteRecallStats(
      totalQuestions: totalQuestions, 
      easy: easyCount, 
      partial: partialCount, 
      forgot: forgotCount,
    );
    final accuracy = totalQuestions == 0 ? 0 : result.accuracy;
    final performance = result.grade.label;
    final performanceColor = result.grade.colour;

    return Scaffold(
      backgroundColor: AppColours.background,
      appBar: AppBar(
        backgroundColor: AppColours.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(color: AppColours.glassBorder, width: 1.5),
        ),
        title: const Text(
          'Session Complete',
          style: TextStyle(
            color: AppColours.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 32),

              // Decorative Achievement Badge Ring
              AchievementBadgeRating(
                performanceColor: performanceColor, 
                accuracy: accuracy, 
                performance: performance,
              ),
              const SizedBox(height: 32),

              // Statistics Panel Block
              StatsAndAiPanel(
                totalQuestions: totalQuestions, 
                easyCount: easyCount, 
                partialCount: partialCount, 
                forgotCount: forgotCount, 
                accuracy: accuracy, 
                performanceColor: performanceColor,
              ),
              const SizedBox(height: 40),

              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColours.geminiGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.refresh_rounded, color: Colors.white, size: 20),
                  label: const Text(
                    'Review Again',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.go(AppRoutes.projects);
                  },
                  icon: const Icon(Icons.home_outlined, size: 20),
                  label: const Text(
                    'Back To Projects',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColours.textPrimary,
                    side: const BorderSide(color: AppColours.glassBorder, width: 1.5),
                    backgroundColor: AppColours.surface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
