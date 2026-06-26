import 'package:flutter/material.dart';

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                ),

                const SizedBox(width: 8),

                Text(
                  'Study Material Added',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              '$questionCount recall questions available',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onEditMaterial,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Material'),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: FilledButton.icon(
                    onPressed: onPreviewQuestions,
                    icon: const Icon(Icons.visibility),
                    label: const Text('Preview'),
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
