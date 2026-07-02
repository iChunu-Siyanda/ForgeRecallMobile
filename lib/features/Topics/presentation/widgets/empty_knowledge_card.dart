import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class EmptyKnowledgeCard extends StatelessWidget {
  final VoidCallback onAddMaterial;

  const EmptyKnowledgeCard({
    super.key,
    required this.onAddMaterial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColours.glassBorder, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ShaderMask gives the icon the specific Gemini Magic Gradient
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => AppColours.geminiGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                size: 52,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'No study material added yet',
              style: TextStyle(
                color: AppColours.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add learning material to generate recall questions for this topic.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColours.textMuted,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                gradient: AppColours.geminiGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton.icon(
                onPressed: onAddMaterial,
                icon: const Icon(Icons.add, color: Colors.white, size: 18),
                label: const Text(
                  'Add Material',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
