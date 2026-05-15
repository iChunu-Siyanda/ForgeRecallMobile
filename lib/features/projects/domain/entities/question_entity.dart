class QuestionEntity {
  final String id;
  final String projectId;
  final String topicId;
  final String question;
  final int answer;
  final String difficulty;
  final String type;
  final DateTime nextReviewDate;
  final double recallStrength;
  final DateTime createdAt;

  const QuestionEntity({
    required this.answer,
    required this.createdAt,
    required this.difficulty,
    required this.id,
    required this.nextReviewDate,
    required this.projectId,
    required this.question,
    required this.recallStrength,
    required this.topicId,
    required this.type,
  });
}
