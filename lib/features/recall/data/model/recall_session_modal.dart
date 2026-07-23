
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/recall/domain/entities/recall_session_entity.dart';

class RecallSessionModel extends RecallSessionEntity {
  const RecallSessionModel({
    required super.id,
    required super.userId,
    required super.projectId,
    required super.score,
    required super.accuracy,
    required super.durationSeconds,
    required super.totalQuestions,
    required super.completedAt, 
    required super.remembered, 
    required super.partial, 
    required super.forgot, 
  });

  factory RecallSessionModel.fromMap(Map<String, dynamic> map) {
    return RecallSessionModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      projectId: map['projectId'] ?? '',
      score: (map['score'] as num).toDouble(),
      accuracy: (map['accuracy'] as num).toDouble(),
      durationSeconds: map['durationSeconds'] ?? 0,
      totalQuestions: map['totalQuestions'] ?? 0,
      completedAt: (map['completedAt'] as Timestamp).toDate(), 
      remembered: map['remembered'] ?? 0, 
      partial: map['partial'] ?? 0, 
      forgot: map['forgot'] ?? 0,
    );
  }

  factory RecallSessionModel.fromEntity(RecallSessionEntity session){
    return RecallSessionModel(
      id: session.id, 
      userId: session.userId, 
      projectId: session.projectId, 
      score: session.score, 
      accuracy: session.accuracy, 
      durationSeconds: session.durationSeconds, 
      totalQuestions: session.totalQuestions, 
      completedAt: session.completedAt, 
      remembered: session.remembered, 
      partial: session.partial, 
      forgot: session.forgot,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'projectId': projectId,
      'score': score,
      'accuracy': accuracy,
      'durationSeconds': durationSeconds,
      'totalQuestions': totalQuestions,
      'completedAt': Timestamp.fromDate(completedAt),
      'remembered': remembered,
      'partial': partial,
      'forgot': forgot,
    };
  }
}
