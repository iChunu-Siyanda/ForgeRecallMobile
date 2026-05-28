import 'package:forge_recall/features/topics/data/models/topic_model.dart';

abstract class TopicRemoteDatasource {
  Stream<List<TopicModel>> getTopics(
    String projectId,
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