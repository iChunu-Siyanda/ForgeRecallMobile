class RecallSessionEntity {
  final String id;
  final String projectId;
  final double score;
  final Duration duration;
  final double accuracy;
  final DateTime completedAt;

  const RecallSessionEntity({
    required this.accuracy,
    required this.completedAt,
    required this.duration,
    required this.id,
    required this.projectId,
    required this.score,
  });
}
