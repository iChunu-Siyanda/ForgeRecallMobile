import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:forge_recall/features/questions/data/datasource/questions_remote_datasource.dart';
import 'package:forge_recall/features/questions/data/model/question_model.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

class QuestionsRemoteDatasourceImpl implements QuestionsRemoteDatasource {
  final FirebaseFirestore firestore;

  QuestionsRemoteDatasourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>>
      get projectsCollection => firestore.collection('projects');

  /// projects/{projectId}/topics/{topicId}/questions
  CollectionReference<Map<String, dynamic>>_questionsCollection(String projectId,String topicId,) {
    return projectsCollection
        .doc(projectId)
        .collection('topics')
        .doc(topicId)
        .collection('questions');
  }

  // projects/{projectId}/topics/{topicId}/questions/{questionId}
  DocumentReference<Map<String, dynamic>>_questionRef(String projectId, String topicId,String questionId,) {
    return _questionsCollection( projectId, topicId,).doc(questionId);
  }

  @override
  Future<List<QuestionEntity>> getQuestions({
    required String projectId,
    required String topicId,
  }) async {
    debugPrint('LOAD PROJECT: $projectId , should be equal to SAVE ROJECT ID.');
    debugPrint('LOAD TOPIC: $topicId');

    final snapshot = await _questionsCollection(
      projectId,
      topicId,
    ).get();

    debugPrint('DOC COUNT: ${snapshot.docs.length}');

    return snapshot.docs.map((doc) {
      return QuestionModel.fromJson({
        'id': doc.id,
        ...doc.data(),
      });
    }).toList();
  }

  @override
  Future<void> saveQuestions({
    required String projectId,
    required String topicId,
    required List<QuestionEntity> questions,
  }) async {
    debugPrint('SAVE PROJECT: $projectId');
    debugPrint('SAVE TOPIC: $topicId');

    final batch = firestore.batch();

    for (final question in questions) {
      final model = QuestionModel.fromEntity(question);

      final docRef = _questionRef(
        projectId,
        topicId,
        question.id,
      );

      batch.set(docRef,model.toJson(),);

      debugPrint('Saving Question: ${question.id} -> ${question.question}',);
    }

    await batch.commit();
  }
}
