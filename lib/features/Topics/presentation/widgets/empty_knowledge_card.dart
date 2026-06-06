import 'package:flutter/material.dart';

class EmptyKnowledgeCard extends StatelessWidget {
  final VoidCallback onAddMaterial;

  const EmptyKnowledgeCard({
    super.key,
    required this.onAddMaterial,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.menu_book_rounded,
              size: 56,
            ),
            const SizedBox(height: 16),

            Text(
              'No study material added yet',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            const SizedBox(height: 8),

            const Text(
              'Add learning material to generate recall questions for this topic.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            FilledButton.icon(
              onPressed: onAddMaterial,
              icon: const Icon(Icons.add),
              label: const Text('Add Material'),
            ),
          ],
        ),
      ),
    );
  }
}