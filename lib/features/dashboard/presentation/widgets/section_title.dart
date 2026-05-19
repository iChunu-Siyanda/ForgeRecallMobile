import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_typography.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.body.copyWith(
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}