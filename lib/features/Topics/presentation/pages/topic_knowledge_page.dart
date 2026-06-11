import 'package:flutter/material.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/presentation/widgets/custom_questions_card.dart';
import 'package:forge_recall/features/topics/presentation/widgets/empty_knowledge_card.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_stats_card.dart';
import 'package:go_router/go_router.dart';

class TopicKnowledgePage extends StatelessWidget {
  final TopicEntity topic;

  const TopicKnowledgePage({
    super.key,
    required this.topic,
  });

  void _showInputMethodSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 15,),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Input Method',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
          
                const SizedBox(height: 10),
          
                ListTile(
                  leading: const Icon(Icons.edit_note),
                  title: const Text('Type Notes'),
                  subtitle: const Text(
                    'Paste study material manually',
                  ),
                  onTap: () {
                    Navigator.pop(context);
          
                    context.go(
                      '/notesInput',
                      extra: topic,
                    );
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
          
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
          onPressed: () { context.go('/projectDetail/${topic.projectId}');}, 
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(topic.title),
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
