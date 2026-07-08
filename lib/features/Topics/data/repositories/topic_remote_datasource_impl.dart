import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  //Search every folder named topics.
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
    debugPrint(
      'TopicQuery: '
      'projectId=${query.projectId}, '
      'filter=${query.filter}, '
      'search=${query.search}',
    );

    Query<Map<String, dynamic>> firestoreQuery =
        query.projectId != null
            ? _topicsRef(query.projectId!)
            : _topicsCollectionGroup;

    switch (query.filter) {
      case TopicFilter.favorites:
        firestoreQuery = firestoreQuery.where(
          'isFavorite',
          isEqualTo: true,
        )
        .orderBy('updatedAt', descending: true);
        break;

      case TopicFilter.completed:
        firestoreQuery = firestoreQuery.where(
          'masteryScore', 
          isGreaterThanOrEqualTo: 95,
          )
          .orderBy('masteryScore')
          .orderBy('updatedAt');
        break;

      case TopicFilter.difficult:
        firestoreQuery = firestoreQuery.where(
          'masteryScore',
          isLessThan: 50,
        )
        .orderBy('masteryScore')
        .orderBy('updatedAt');
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
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => TopicModel.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                }),
              )
              .toList(),
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
  
  @override
  Future<void> toggleFavorite(String projectId, String topicId, bool isFavorite) async {
    return await _topicsRef(projectId)
                .doc(topicId)
                .update({
                  'isFavorite': isFavorite,
                  'updatedAt': Timestamp.now(),
                });
  }
  
  @override
  Future<void> updateTopicStats(
    TopicModel topic
  ) async {
    await _topicsRef(topic.projectId)
        .doc(topic.id)
        .update(
          topic.toJson(),
        );
  }
}
