import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/recall/presentation/widgets/achievement_badge_rating.dart';
import 'package:forge_recall/features/recall/presentation/widgets/stats_and_si_panel.dart';
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
    final accuracy = totalQuestions == 0
        ? 0
        : (((easyCount + (partialCount * 0.5)) / totalQuestions) * 100).round();

    final performance = switch (accuracy) {
      >= 90 => 'Mastery',
      >= 75 => 'Strong Recall',
      >= 60 => 'Developing',
      _ => 'Needs Reinforcement',
    };

    final performanceColor = switch (accuracy) {
      >= 90 => AppColours.emerald,
      >= 75 => AppColours.electricBlue,
      >= 60 => AppColours.amber,
      _ => AppColours.crimson,
    };

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
