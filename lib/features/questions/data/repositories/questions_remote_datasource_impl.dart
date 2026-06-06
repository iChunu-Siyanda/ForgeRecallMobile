import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/questions/domain/entities/topics_questions_entity.dart';
import 'package:forge_recall/features/questions/data/model/questions_model.dart';
import 'package:forge_recall/features/questions/data/datasource/questions_remote_datasource.dart';

class QuestionsRemoteDatasourceImpl implements QuestionsRemoteDatasource{
  final FirebaseFirestore firestore;
  QuestionsRemoteDatasourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>> get projectsCollection => firestore.collection('projects');

  DocumentReference<Map<String, dynamic>>_questionsRef(String projectId, String topicId, String questionsId) {
    return projectsCollection
        .doc(projectId)
        .collection('topics')
        .doc(topicId)
        .collection('questions')
        .doc(questionsId);
  }

  @override
  Future<TopicQuestionsEntity> getTopicQuestions(String questionsId, String topicId, String projectId) async {
    final snapshot = await _questionsRef(projectId, topicId, questionsId).get();
    
    if (!snapshot.exists) {
      throw Exception('Questions document not found');
    }

    return QuestionsModel.fromJson(snapshot.data()!);
  }

}