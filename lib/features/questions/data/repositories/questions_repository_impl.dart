import 'package:forge_recall/features/questions/domain/entities/topics_questions_entity.dart';
import 'package:forge_recall/features/questions/data/datasource/questions_remote_datasource.dart';
import 'package:forge_recall/features/questions/domain/repositories/questions_repository.dart';

class QuestionsRepositoryImpl implements QuestionsRepository{
  final QuestionsRemoteDatasource repository;
  QuestionsRepositoryImpl(this.repository);

  @override
  Future<TopicQuestionsEntity> getTopicQuestions(String questionsId, String topicId, String projectId) {
    return repository.getTopicQuestions(questionsId, topicId, projectId);
  }
}