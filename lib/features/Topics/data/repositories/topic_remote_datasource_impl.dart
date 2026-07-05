import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/core/shared/entites/topic_filter.dart';
import 'package:forge_recall/features/topics/data/datasource/topic_remote_datasource.dart';
import 'package:forge_recall/features/topics/data/models/topic_model.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';

class TopicRemoteDatasourceImpl implements TopicRemoteDatasource {
  final FirebaseFirestore firestore;
  TopicRemoteDatasourceImpl(this.firestore);

  final projectsCollection = FirebaseFirestore.instance.collection('projects');

  CollectionReference<Map<String, dynamic>>_topicsRef(String projectId) {
    return projectsCollection
        .doc(projectId)
        .collection('topics');
  }
  Query<Map<String, dynamic>> get _topicsCollectionGroup => firestore.collectionGroup('topics');

  @override
  Future<TopicModel> fetchTopicById(
    String topicId, 
    String projectId,
  ) async {
    final snapshot = await _topicsRef(projectId).doc(topicId).get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception("Topic not found");
    }
    
    return TopicModel.fromJson(snapshot.data()!);
  }

  @override
  Stream<List<TopicModel>> getTopics(
    TopicQuery query,
  ) {

    Query<Map<String, dynamic>> firestoreQuery = query.projectId != null ? _topicsRef(query.projectId!): _topicsCollectionGroup;

    if (query.projectId != null) {
      firestoreQuery = firestoreQuery.where(
        'projectId',
        isEqualTo: query.projectId,
      );
    }

    switch (query.filter) {
      case TopicFilter.favorites:
        firestoreQuery = firestoreQuery.where(
          'isFavorite',
          isEqualTo: true,
        );
        break;

      case TopicFilter.completed:
        firestoreQuery = firestoreQuery.where(
          'masteryScore',
          isGreaterThanOrEqualTo: 95,
        );
        break;

      case TopicFilter.difficult:
        firestoreQuery = firestoreQuery.where(
          'masteryScore',
          isLessThan: 50,
        );
        break;

      case TopicFilter.recent:
        firestoreQuery = firestoreQuery.orderBy(
          'lastStudiedAt',
          descending: true,
        );
        break;

      case TopicFilter.allTopics:
      case null:
        break;
    }

    return firestoreQuery
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TopicModel.fromJson({
              'id': doc.id,
              ...doc.data(),
            });
          }).toList();
        });
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
