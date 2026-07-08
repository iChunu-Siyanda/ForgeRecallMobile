import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';

abstract class TopicRepository {
  //get topics
  Stream<List<TopicEntity>> getTopics(TopicQuery query);

  //Get single topic
  Future<TopicEntity> fetchTopicById(String topicId, String projectId);
  
  //create topics
  Future<void> createTopics(TopicEntity topic);

  //update topics
  Future<void> updateTopics(TopicEntity topic);

  //delete topics
  Future<void> deleteTopic(String topicId, String projectId);

  //Add to favorites
  Future<void> toggleFavorite(
    String projectId,
    String topicId,
    bool isFavorite,
  );
}
