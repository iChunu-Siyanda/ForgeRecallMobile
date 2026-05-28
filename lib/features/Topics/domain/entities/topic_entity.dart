class TopicEntity {
  final String id;
  final String projectId;
  final String title;
  final String content;
  final double masteryScore;
  final int questionCount;
  final int estimatedReadTime;
  final double cognitiveDifficulty;
  final DateTime createdAt;
  final DateTime updatedAt;

  TopicEntity({
    required this.id,
    required this.projectId,
    required this.title,
    required this.content,
    required this.masteryScore,
    required this.questionCount,
    required this.estimatedReadTime,
    required this.cognitiveDifficulty,
    required this.createdAt,
    required this.updatedAt,
  });
}