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
  Stream<List<TopicEntity>> getTopics(String projectId) {
    // 1. Fetch your raw database stream of topics just like before
    return repository.getTopics(projectId).switchMap((List<TopicEntity> rawTopics) {
      if (rawTopics.isEmpty) {
        return Stream.value(<TopicEntity>[]);
      }

      // 2. Loop through the list to look up corresponding questions streams
      final combinedTopicStreams = rawTopics.map((topic) {
          return questionRepository.getQuestions(
            projectId: projectId,
            topicId: topic.id,
          )
          .map((questions) {
            final count = questions.length;

            return topic.copyWith(
              questionCount: count,
            );
          });
      }).toList();

      // 3. Flatten them back into a single clean Stream<List<TopicEntity>>
      return Rx.combineLatestList(combinedTopicStreams);
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
}
