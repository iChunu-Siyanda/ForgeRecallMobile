import 'package:forge_recall/features/questions/domain/entities/topics_questions_entity.dart';
import 'package:forge_recall/features/questions/domain/repositories/questions_repository.dart';

class GetTopicsQuestionsUserCase {
  final QuestionsRepository repository;
  GetTopicsQuestionsUserCase(this.repository);

  Future<TopicQuestionsEntity> call(String questionsId, String topicId, String projectId) {
    return repository.getTopicQuestions(questionsId, topicId, projectId);
  }
}