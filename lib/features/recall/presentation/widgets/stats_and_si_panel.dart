import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class StatsAndAiPanel extends StatelessWidget {
  const StatsAndAiPanel({
    super.key,
    required this.totalQuestions,
    required this.easyCount,
    required this.partialCount,
    required this.forgotCount,
    required this.accuracy,
    required this.performanceColor,
  });

  final int totalQuestions;
  final int easyCount;
  final int partialCount;
  final int forgotCount;
  final int accuracy;
  final Color performanceColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    
      ],
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
