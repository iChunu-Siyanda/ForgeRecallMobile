import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class RecallStatsTracking extends StatelessWidget {
  const RecallStatsTracking({
    super.key,
    required this.currentIdx,
    required this.totalCount,
  });

  final int currentIdx;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SESSION PROGRESS',
              style: TextStyle(
                color: AppColours.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
            Text(
              '$currentIdx of $totalCount',
              style: const TextStyle(
                color: AppColours.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
    
        const SizedBox(height: 8),
    
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: currentIdx / totalCount,
            minHeight: 6,
            backgroundColor: AppColours.surfaceSecondary,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
          ),
        ),
      ],
    );
  }
}
