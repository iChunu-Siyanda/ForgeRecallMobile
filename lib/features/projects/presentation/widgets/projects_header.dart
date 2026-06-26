import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class ProjectsHeader extends StatelessWidget {
  const ProjectsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'PROJECTS',
              style: TextStyle(
                color: AppColours.textPrimary,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Forge mastery through repetition.',
              style: TextStyle(
                color: AppColours.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppColours.glassBorder.withValues(alpha: 0.05),
            border: Border.all(
              color: AppColours.glassBorder.withValues(alpha: 0.08),
            ),
          ),
          child: const Icon(
            Icons.search_rounded,
            color: AppColours.textPrimary,
          ),
        ),
      ],
    );
  }
}
