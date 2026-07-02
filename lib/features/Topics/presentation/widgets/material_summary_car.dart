import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class MaterialSummaryCard extends StatelessWidget {
  final int questionCount;
  final VoidCallback onEditMaterial;
  final VoidCallback onPreviewQuestions;

  const MaterialSummaryCard({
    super.key,
    required this.questionCount,
    required this.onEditMaterial,
    required this.onPreviewQuestions,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColours.emerald,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  'Study Material Added',
                  style: TextStyle(
                    color: AppColours.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '$questionCount recall questions available',
              style: TextStyle(
                color: AppColours.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onEditMaterial,
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: const Text('Edit Material'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColours.electricBlue,
                      side: const BorderSide(color: AppColours.glassBorder, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColours.geminiGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: onPreviewQuestions,
                      icon: const Icon(Icons.visibility_outlined, size: 18, color: Colors.white),
                      label: const Text(
                        'Preview',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
