import 'package:flutter/material.dart';
import 'package:forge_recall/core/widgets/forge_card.dart';
import 'package:forge_recall/core/theme/app_typography.dart';

class RecallModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final String stats;

  const RecallModeCard({
    super.key, 
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},

      child: ForgeCard(
        child: Row(
          children: [

            Container(
              width: 58,
              height: 58,

              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
              ),

              child: Icon(
                icon,
                color: accent,
                size: 28,
              ),
            ),

            const SizedBox(width: 18),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                Text(
                  title,
                  style: AppTypography.headlineMedium.copyWith(
                    fontSize: 18,
                  ),
                ),
            
                const SizedBox(height: 8),
            
                Text(
                  subtitle,
                  style: AppTypography.body,
                ),
            
                const SizedBox(height: 10),
            
                Text(
                  stats,
                  style: AppTypography.body.copyWith(
                    color: accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}
