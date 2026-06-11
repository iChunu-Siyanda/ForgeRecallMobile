import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/domain/repositories/questions_repository.dart';

class SaveQuestionsUseCase {
  final QuestionsRepository repository;
  SaveQuestionsUseCase(this.repository,);

  Future<void> call({
    required String projectId,
    required String topicId,
    required List<QuestionEntity> questions,
  }) {
    return repository.saveQuestions(
      projectId: projectId,
      topicId: topicId,
      questions: questions,
    );
  }
}