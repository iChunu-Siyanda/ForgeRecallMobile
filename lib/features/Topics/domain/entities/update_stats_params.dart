class UpdateStatsParams {
  final String topicId;
  final String projectId;
  final double masteryScore;
  final double cognitiveDifficulty;
  final int studyCount;
  final DateTime lastStudiedAt;

  const UpdateStatsParams({
    required this.topicId,
    required this.projectId,
    required this.masteryScore,
    required this.cognitiveDifficulty,
    required this.studyCount,
    required this.lastStudiedAt,
  });
}
