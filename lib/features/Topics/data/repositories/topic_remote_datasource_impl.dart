import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/Topics/data/datasource/topic_remote_datasource.dart';
import 'package:forge_recall/features/topics/data/models/topic_model.dart';

class TopicRemoteDatasourceImpl
    implements TopicRemoteDatasource {
  final FirebaseFirestore firestore;
  TopicRemoteDatasourceImpl(this.firestore);

  final projectsCollection = FirebaseFirestore.instance.collection('projects');

  CollectionReference<Map<String, dynamic>>_topicsRef(String projectId) {
    return projectsCollection
        .doc(projectId)
        .collection('topics');
  }

  @override
  Stream<List<TopicModel>> getTopics(
    String projectId,
  ) {
    return _topicsRef(projectId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc){
          return TopicModel.fromJson({
            'id': doc.id,
            ...doc.data(),
          });
        }).toList();  
      },
    );
  }

  @override
  Future<void> createTopic(
    TopicModel topic,
  ) async {
    final docRef = _topicsRef(
      topic.projectId,
    ).doc(topic.id);
    
    await docRef.set(topic.toJson());
  }

  @override
  Future<void> updateTopic(
    TopicModel topic,
  ) async {
    await _topicsRef(topic.projectId)
        .doc(topic.id)
        .update(
          topic.toJson(),
        );
  }

  @override
  Future<void> deleteTopic(
    String projectId,
    String topicId,
  ) async {
    await _topicsRef(projectId)
        .doc(topicId)
        .delete();
  }
}