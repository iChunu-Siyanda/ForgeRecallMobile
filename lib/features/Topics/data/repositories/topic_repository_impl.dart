import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:forge_recall/features/questions/data/datasource/questions_remote_datasource.dart';
import 'package:forge_recall/features/topics/data/datasource/topic_remote_datasource.dart';
import 'package:forge_recall/features/topics/data/models/topic_model.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';
import 'package:rxdart/rxdart.dart';

class TopicRepositoryImpl implements TopicRepository{
  final TopicRemoteDatasource repository;
  final QuestionsRemoteDatasource questionRepository;
  TopicRepositoryImpl(this.repository, this.questionRepository);

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
  Stream<List<TopicEntity>> getTopics(
    TopicQuery query,
  ) {
    return repository
        .getTopics(query)
        .switchMap((rawTopics) {
          if (rawTopics.isEmpty) {
            return Stream.value(<TopicEntity>[]);
          }

          final topicStreams = rawTopics.map((topic) {
            return questionRepository
                .getQuestions(
                  projectId: topic.projectId,
                  topicId: topic.id,
                )
                .map((questions) {
                  return topic.copyWith(
                    questionCount: questions.length,
                  );
                });
          }).toList();

          return Rx.combineLatestList(topicStreams);
        });
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
  
  @override
  Future<void> toggleFavorite(String projectId, String topicId, bool isFavorite) {
    return repository.toggleFavorite(projectId, topicId, isFavorite);
  }
}
