import 'package:forge_recall/features/topics/data/models/topic_model.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/questions/domain/entities/topics_questions_entity.dart';

abstract class TopicRemoteDatasource {
  Stream<List<TopicModel>> getTopics(
    String projectId,
  );

  Future<TopicEntity> fetchTopicById(
    String topicId, 
    String projectId
  );

  Future<void> createTopic(
    TopicModel topic,
  );

  Future<void> updateTopic(
    TopicModel topic,
  );

  Future<void> deleteTopic(
    String projectId,
    String topicId,
  );
}