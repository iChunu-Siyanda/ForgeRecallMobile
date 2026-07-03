import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
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
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: performanceColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.emoji_events_rounded,
                    size: 72,
                    color: performanceColor,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                '$accuracy%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColours.textPrimary,
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                performance,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: performanceColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Active recall session completed successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColours.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 32),

              // Statistics Panel Block
              Container(
                decoration: BoxDecoration(
                  color: AppColours.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColours.glassBorder, width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _StatRow(
                        label: 'Questions Reviewed',
                        value: '$totalQuestions',
                        isHeader: true,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(height: 1, color: AppColours.glassBorder),
                      ),
                      _StatRow(label: '😎  Easy', value: '$easyCount'),
                      _StatRow(label: '🤔  Partial', value: '$partialCount'),
                      _StatRow(label: '😵  Forgot', value: '$forgotCount'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(height: 1, color: AppColours.glassBorder),
                      ),
                      _StatRow(
                        label: 'Total Accuracy',
                        value: '$accuracy%',
                        valueColor: performanceColor,
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // AI Feedback Panel Block
              Container(
                decoration: BoxDecoration(
                  color: AppColours.surfaceSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColours.glassBorder),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.psychology_rounded,
                        color: AppColours.geminiPurple,
                        size: 28,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          accuracy >= 75
                              ? 'Your memory traces are strengthening. Continue reviewing on schedule to consolidate this neural knowledge base.'
                              : 'Several foundational concepts need reinforcement. A fast follow-up review cycle is highly recommended.',
                          style: const TextStyle(
                            color: AppColours.textSecondary,
                            fontSize: 14,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isHeader;
  final bool isBold;

  const _StatRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isHeader = false,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = isHeader ? AppColours.textSecondary : AppColours.textPrimary;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isHeader ? AppColours.textSecondary : AppColours.textPrimary,
                fontSize: isHeader ? 13 : 15,
                fontWeight: (isHeader || isBold) ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? defaultColor,
              fontSize: isHeader ? 14 : 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
