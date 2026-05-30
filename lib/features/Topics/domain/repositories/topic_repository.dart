import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

abstract class TopicRepository {
  //get topics
  Stream<List<TopicEntity>> getTopics(String projectId);
  
  //create topics
  Future<void> createTopics(TopicEntity topic);

  //update topics
  Future<void> updateTopics(TopicEntity topic);

  //delete topics
  Future<void> deleteTopic(String topicId, String projectId);
}