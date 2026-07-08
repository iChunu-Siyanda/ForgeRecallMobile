import 'package:forge_recall/features/topics/data/models/topic_model.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';

abstract class TopicRemoteDatasource {
  Stream<List<TopicModel>> getTopics(
    TopicQuery query,
  );

  Future<TopicModel> fetchTopicById(
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

  Future<void> toggleFavorite(
    String projectId,
    String topicId,
    bool isFavorite,
  );
}
