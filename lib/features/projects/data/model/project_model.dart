import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.masteryPercentage,
    required super.totalTopics,
    required super.totalQuestions,
    required super.userId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      masteryPercentage: (json['masteryPercentage'] as num).toDouble(),
      totalTopics: json['totalTopics'],
      totalQuestions: json['totalQuestions'],
      userId: json['userId'],
      createdAt: json['createdAt'] != null
        ? json['createdAt'].toDate()
        : DateTime.now(),
      updatedAt: json['updatedAt'] != null
        ? json['updatedAt'].toDate()
        : DateTime.now(),
    );
  }

  factory ProjectModel.fromEntity(ProjectEntity entity) {
    return ProjectModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      masteryPercentage: entity.masteryPercentage,
      totalTopics: entity.totalTopics,
      totalQuestions: entity.totalQuestions,
      userId: entity.userId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'masteryPercentage': masteryPercentage,
      'totalTopics': totalTopics,
      'totalQuestions': totalQuestions,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
