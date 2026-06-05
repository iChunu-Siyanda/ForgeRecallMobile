import 'package:forge_recall/features/topics/data/models/topic_model.dart';
import 'package:forge_recall/features/topics/data/repositories/topic_remote_datasource_impl.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class TopicRepositoryImpl implements TopicRepository{
  final TopicRemoteDatasourceImpl repository;
  TopicRepositoryImpl(this.repository);

  @override
  Future<void> createTopics(TopicEntity topic) async {
    final model = TopicModel.fromEntity(topic);
    await repository.createTopic(model);
  }

  @override
  Future<void> deleteTopic(String topicId, String projectId) async {
    await repository.deleteTopic(projectId, topicId);
  }

  @override
  Stream<List<TopicEntity>> getTopics(String projectId) {
    return repository.getTopics(projectId);
  }

  @override
  Future<void> updateTopics(TopicEntity topic) async {
    final model = TopicModel.fromEntity(topic);
    await repository.updateTopic(model);
  }
  
  @override
  Future<TopicEntity> fetchTopicById(String topicId, String projectId) {
    return repository.fetchTopicById(topicId, projectId);
  }
}