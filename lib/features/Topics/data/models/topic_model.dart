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
  });

  factory TopicModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return TopicModel(
      id: doc.id,
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
    );
  }

  Map<String, dynamic> toMap() {
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
    };
  }

  TopicModel copyWith({
    String? id,
    String? projectId,
    String? title,
    String? content,
    double? masteryScore,
    int? questionCount,
    int? estimatedReadTime,
    double? cognitiveDifficulty,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TopicModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      content: content ?? this.content,
      masteryScore:
          masteryScore ?? this.masteryScore,
      questionCount:
          questionCount ?? this.questionCount,
      estimatedReadTime:
          estimatedReadTime ??
              this.estimatedReadTime,
      cognitiveDifficulty:
          cognitiveDifficulty ??
              this.cognitiveDifficulty,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}