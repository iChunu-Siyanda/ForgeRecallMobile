import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/domain/repositories/questions_repository.dart';

class GetQuestionsPrevUseCase {
  final QuestionsRepository repository;
  GetQuestionsPrevUseCase(this.repository);

  Future<List<QuestionEntity>> call(
    String projectId, 
    String topicId) {
    return repository.getPrevQuestions(
      projectId: projectId, 
      topicId: topicId,
    );
  }
}
