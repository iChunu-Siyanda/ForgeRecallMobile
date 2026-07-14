import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class SearchInitialCard extends StatelessWidget {
  const SearchInitialCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColours.surfaceSecondary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.search_rounded,
            size: 40,
            color: AppColours.textMuted,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Find your topics',
          style: TextStyle(
            color: AppColours.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Search through all of your saved materials.',
          style: TextStyle(
            color: AppColours.textMuted,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
