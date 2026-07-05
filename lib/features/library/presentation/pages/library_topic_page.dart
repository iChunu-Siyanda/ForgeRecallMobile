import 'package:flutter/material.dart';
import 'package:forge_recall/features/library/domain/entities/library_filter.dart';
import 'package:forge_recall/features/library/presentation/widgets/library_topic_card.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class LibraryTopicsPage extends StatelessWidget {
  final String title;
  final LibraryFilter filter;

  const LibraryTopicsPage({
    super.key,
    required this.title,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final topics = <TopicEntity>[];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length, 
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final topic = topics[index];

          return LibraryTopicCard(topic: topic);
        },
      ),
    );
  }
}
