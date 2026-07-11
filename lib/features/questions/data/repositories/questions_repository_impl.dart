import 'package:forge_recall/features/questions/data/datasource/questions_remote_datasource.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/domain/repositories/questions_repository.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsRemoteDatasource remoteDatasource;
  QuestionsRepositoryImpl(this.remoteDatasource,);

  @override
  Stream<List<QuestionEntity>> getQuestions({
    required String projectId,
    required String topicId,
  }) {
    return remoteDatasource.getQuestions(
      projectId: projectId,
      topicId: topicId,
    );
  }

  @override
  Future<void> saveQuestions({
    required String projectId,
    required String topicId,
    required List<QuestionEntity> questions,
  }) {
    return remoteDatasource.saveQuestions(
      projectId: projectId,
      topicId: topicId,
      questions: questions,
    );
  }
  
  @override
  Future<List<QuestionEntity>> getPrevQuestions({
    required String projectId, 
    required String topicId,
  }) {
    return remoteDatasource.getPrevQuestions(
      projectId: projectId, 
      topicId: topicId,
    );
  }
}
