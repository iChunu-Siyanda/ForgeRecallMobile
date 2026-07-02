import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class TopicSectionHeader extends StatelessWidget {
  const TopicSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Knowledge Architecture',
              style: TextStyle(
                color: AppColours.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: -0.5,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Transform information into recall-ready mastery',
              style: TextStyle(
                color: AppColours.textSecondary,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),

        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => AppColours.geminiGradient.createShader(bounds),
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // Soft alpha overlay using your premium violet accent
              color: AppColours.violet.withValues(alpha: 0.1), 
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 24, // Keeps it crisp inside the frame
            ),
          ),
        )

        // Container(
        //   height: 48,
        //   width: 48,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(16),
        //     color: AppColours.surfaceSecondary, // Soft tint for workspace elements
        //   ),
        //   child: const Icon(
        //     Icons.auto_awesome_rounded,
        //     color: AppColours.electricBlue, // Professional core brand blue
        //   ),
        // ),
      ],
    );
  }
}
