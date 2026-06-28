import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

abstract class QuestionsRepository {
  Future<void> saveQuestions({
    required String projectId,
    required String topicId,
    required List<QuestionEntity> questions,
  });

  Stream<List<QuestionEntity>> getQuestions({
    required String projectId,
    required String topicId,
  });
}
