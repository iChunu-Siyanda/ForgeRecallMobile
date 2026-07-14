import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class SearchErrorPage extends StatelessWidget {
  final String msg;
  const SearchErrorPage({
    super.key,
    required this.msg
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColours.crimson.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: AppColours.crimson,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Search Error',
              style: TextStyle(
                color: AppColours.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColours.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
