import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class TopicModel extends TopicEntity {
  TopicModel({
    required super.id,
    required super.projectId,
    required super.title,
    required super.content,
    required super.masteryScore,
    required super.questionCount,
    required super.estimatedReadTime,
    required super.cognitiveDifficulty,
    required super.createdAt,
    required super.updatedAt, 
    required super.isFavorite, 
    required super.studyCount,
  });

  factory TopicModel.fromJson(
    Map<String, dynamic> data,
  ) {
    return TopicModel(
      id: data['id'],
      projectId: data['projectId'] ?? '',

      title: data['title'] ?? '',
      content: data['content'] ?? '',

      masteryScore:
          (data['masteryScore'] ?? 0).toDouble(),

      questionCount:
          data['questionCount'] ?? 0,

      estimatedReadTime:
          data['estimatedReadTime'] ?? 0,

      cognitiveDifficulty:
          (data['cognitiveDifficulty'] ?? 0).toDouble(),

      createdAt:
          (data['createdAt'] as Timestamp).toDate(),

      updatedAt:
          (data['updatedAt'] as Timestamp).toDate(), 
      isFavorite: data['isFavorite'] ?? false, 
      studyCount: data['studyCount'] ?? 0,
    );
  }

  factory TopicModel.fromEntity(TopicEntity topic){
    return TopicModel(
      id: topic.id, 
      projectId: topic.projectId, 
      title: topic.title, 
      content: topic.content, 
      masteryScore: topic.masteryScore, 
      questionCount: topic.questionCount, 
      estimatedReadTime: topic.estimatedReadTime, 
      cognitiveDifficulty: topic.cognitiveDifficulty, 
      createdAt: topic.createdAt, 
      updatedAt: topic.updatedAt, 
      isFavorite: topic.isFavorite, 
      studyCount: topic.studyCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'title': title,
      'content': content,
      'masteryScore': masteryScore,
      'questionCount': questionCount,
      'estimatedReadTime': estimatedReadTime,
      'cognitiveDifficulty': cognitiveDifficulty,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isFavorite': isFavorite,
      'studyCount': studyCount,
    };
  }
}
