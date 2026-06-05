import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/Topics/data/datasource/topic_remote_datasource.dart';
import 'package:forge_recall/features/topics/data/models/topic_model.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class TopicRemoteDatasourceImpl implements TopicRemoteDatasource {
  final FirebaseFirestore firestore;
  TopicRemoteDatasourceImpl(this.firestore);

  final projectsCollection = FirebaseFirestore.instance.collection('projects');

  CollectionReference<Map<String, dynamic>>_topicsRef(String projectId) {
    return projectsCollection
        .doc(projectId)
        .collection('topics');
  }

  @override
  Future<TopicEntity> fetchTopicById(
    String topicId, 
    String projectId,
  ) async {
    // 1. Fetch the document snapshot from Firestore
    final snapshot = await _topicsRef(projectId).doc(topicId).get();

    // 2. Check if the document actually exists
    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception("Topic not found"); 
      // Or return a default value / handle errors according to your app's architecture
    }

    return TopicModel.fromJson(snapshot.data()!);
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