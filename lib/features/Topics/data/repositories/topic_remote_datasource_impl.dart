import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/Topics/data/datasource/topic_remote_datasource.dart';
import 'package:forge_recall/features/topics/data/models/topic_model.dart';

class TopicRemoteDatasourceImpl
    implements TopicRemoteDatasource {
  final FirebaseFirestore firestore;

  TopicRemoteDatasourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>>
      _topicsRef(String projectId) {
    return firestore
        .collection('projects')
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
        return snapshot.docs
            .map(TopicModel.fromFirestore)
            .toList();
      },
    );
  }

  @override
  Future<void> createTopic(
    TopicModel topic,
  ) async {
    final docRef = _topicsRef(
      topic.projectId,
    ).doc();

    final topicWithId = topic.copyWith(
      id: docRef.id,
    );

    await docRef.set(
      topicWithId.toMap(),
    );
  }

  @override
  Future<void> updateTopic(
    TopicModel topic,
  ) async {
    await _topicsRef(topic.projectId)
        .doc(topic.id)
        .update(
          topic.toMap(),
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