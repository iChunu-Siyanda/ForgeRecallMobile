import 'package:forge_recall/features/topics/domain/entities/create_topic_params.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';
import 'package:uuid/uuid.dart';

class CreateTopicUseCase {
  final TopicRepository repository;
  CreateTopicUseCase(this.repository);

  Future<void> call(CreateTopicParams params) async {
    // Capture the exact time the topic is being generated
    final now = DateTime.now();

    final topicWithId = TopicEntity(
      id: const Uuid().v4(),
      projectId: params.projectId,
      title: params.title,
      content: params.content,
      masteryScore: 0.0,        
      questionCount: 0,         
      estimatedReadTime: _calculateReadTime(params.content), 
      cognitiveDifficulty: 0.0, 
      createdAt: now,
      updatedAt: now,
    );

    return repository.createTopics(topicWithId);
  }

  int _calculateReadTime(String content) {
    final wordCount = content.split(' ').length;
    // Average reading speed is roughly 200 words per minute
    final minutes = (wordCount / 200).ceil();
    return minutes > 0 ? minutes : 1; 
  }
  }