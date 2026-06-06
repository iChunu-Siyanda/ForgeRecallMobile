import 'package:flutter/material.dart';
import 'package:forge_recall/features/topics/presentation/widgets/custom_questions_card.dart';
import 'package:forge_recall/features/topics/presentation/widgets/empty_knowledge_card.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_stats_card.dart';

class TopicKnowledgePage extends StatelessWidget {
  final String topicTitle;

  const TopicKnowledgePage({
    super.key,
    required this.topicTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(topicTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            EmptyKnowledgeCard(
              onAddMaterial: () {
                _showInputMethodSheet(context);
              },
            ),

            const SizedBox(height: 16),

            CustomQuestionsCard(
              onAddQuestion: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Custom Questions Coming Soon'),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            const TopicStatsCard(),
          ],
        ),
      ),
    );
  }
}

void _showInputMethodSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Input Method',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.edit_note),
              title: const Text('Type Notes'),
              subtitle: const Text(
                'Paste study material manually',
              ),
              onTap: () {
                Navigator.pop(context);

                // Navigate to Notes Input Page
              },
            ),

            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Upload Image'),
              subtitle: const Text('Coming Soon'),
              enabled: false,
            ),

            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Upload PDF'),
              subtitle: const Text('Coming Soon'),
              enabled: false,
            ),

            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}

