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

    final data = Map<String, dynamic>.from(snapshot.data()!);

    // Firestore adaptation
    data['id'] = snapshot.id;
    //debugPrint('fetchProjectById: ${snapshot.id}');

    return TopicModel.fromJson(data);
  }

  @override
  Stream<List<TopicModel>> getTopics(
    TopicQuery query,
  ) {
    debugPrint(
      'TopicQuery In Topic Repo: '
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

    if (query.search != null && query.search!.trim().isNotEmpty) {
      final search = query.search!.trim().toLowerCase();
      debugPrint("Searching...");
      firestoreQuery = firestoreQuery.where(
        'titleLower',
        isGreaterThanOrEqualTo: search,
      )
      .where(
          'titleLower',
          isLessThan: '$search\uf8ff',
      );
    }
    
    return firestoreQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = {
          'id': doc.id,
          ...doc.data(),
        };
        //debugPrint('getTopics in TopicRemoteDatasounceImple:');
        // debugPrint('Topic: ${doc.id}');
        // debugPrint("$data");

        return TopicModel.fromJson(data);
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
    debugPrint('Update Topic Stats Repo:');
    //debugPrint(topic.toJson().toString());
    await _topicsRef(topic.projectId)
        .doc(topic.id)
        .update(
          topic.toJson(),
        );
  }
}
