import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

abstract class QuestionsRemoteDatasource {
  Future<void> saveQuestions({
    required String projectId,
    required String topicId,
    required List<QuestionEntity> questions,
  });

  Future<List<QuestionEntity>> getQuestions({
    required String projectId,
    required String topicId,
  });
}