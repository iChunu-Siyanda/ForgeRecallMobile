class RecallSessionEntity {
  final String id;
  final String userId;
  final String projectId;

  final double score;
  final double accuracy;

  final int remembered;
  final int partial;
  final int forgot;

  final int durationSeconds;
  final int totalQuestions;

  final DateTime completedAt;

  const RecallSessionEntity({
    required this.id,
    required this.userId,
    required this.projectId,
    required this.score,
    required this.accuracy,
    required this.durationSeconds,
    required this.totalQuestions,
    required this.completedAt, 
    required this.remembered, 
    required this.partial, 
    required this.forgot,
  });
}
