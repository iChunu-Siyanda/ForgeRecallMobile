import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class ProjectSectionTitle extends StatelessWidget {
  const ProjectSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'ACTIVE PROJECTS',
            style: TextStyle(
              color: AppColours.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          Text(
            'View All',
            style: TextStyle(
              color: AppColours.violet,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
