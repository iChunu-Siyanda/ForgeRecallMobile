class TopicEntity {
  final String id;
  final String projectId;
  final String title;
  final double projectMastery;
  final double weaknessScore;
  final DateTime createdAt;

  const TopicEntity({
    required this.createdAt,
    required this.id,
    required this.projectId,
    required this.projectMastery,
    required this.title,
    required this.weaknessScore,
  });
}
