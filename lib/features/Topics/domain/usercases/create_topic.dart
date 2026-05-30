import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';
import 'package:uuid/uuid.dart';

abstract class CreateTopic {
  final TopicRepository repository;
  CreateTopic(this.repository);

  Future<void> call(TopicEntity topic) async {
     final topicWithId = TopicEntity(
      id: const Uuid().v4(),
      projectId: topic.projectId,
      title: topic.title,
      content: topic.content,
      masteryScore: topic.masteryScore,
      questionCount: topic.questionCount,
      estimatedReadTime: topic.estimatedReadTime,
      cognitiveDifficulty: topic.cognitiveDifficulty,
      createdAt: topic.createdAt,
      updatedAt: topic.updatedAt,
    );

    return repository.createTopics(topicWithId);
  }
}