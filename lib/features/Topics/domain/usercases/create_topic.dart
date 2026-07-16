import 'package:forge_recall/features/topics/domain/entities/create_topic_params.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';
import 'package:uuid/uuid.dart';

class CreateTopicUseCase {
  final TopicRepository repository;
  CreateTopicUseCase(this.repository);

  Future<void> call(
    CreateTopicParams params,
  ) async {
    final now = DateTime.now();

    final topic = TopicEntity(
      id: const Uuid().v4(),
      projectId: params.projectId,
      title: params.title,
      titleLower: params.title.toLowerCase(),
      content: params.material,
      masteryScore: 0.0,        
      questionCount: 0,         
      estimatedReadTime: _calculateReadTime(params.material), 
      cognitiveDifficulty: 0.0, 
      createdAt: now,
      updatedAt: now, 
      //TODO: implement isFavorite and studyCout
      isFavorite: false, 
      studyCount: 0, 
      lastStudiedAt: now,
    );

    return repository.createTopics(topic);
  }

  int _calculateReadTime(String material) {
    final wordCount = material.split(' ').length;
    // Average reading speed is roughly 200 words per minute
    final minutes = (wordCount / 200).ceil();
    return minutes > 0 ? minutes : 1; 
  }
}
