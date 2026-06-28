import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/domain/repositories/questions_repository.dart';

class GetTopicsQuestionsUseCase {
  final QuestionsRepository repository;
  GetTopicsQuestionsUseCase(this.repository);

  Stream<List<QuestionEntity>> call(String projectId, String topicId) {
    return repository.getQuestions(projectId: projectId, topicId: topicId);
  }
}
