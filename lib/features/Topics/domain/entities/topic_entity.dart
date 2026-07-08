class TopicEntity {
  final String id;
  final String projectId;
  final String title;
  final String content;
  final double masteryScore;
  final int questionCount;
  final int estimatedReadTime;
  final double cognitiveDifficulty;
  final bool isFavorite;
  final DateTime? lastStudiedAt;
  DateTime? nextReviewAt;
  final int studyCount;
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
    required this.isFavorite, 
    required this.studyCount,
    this.lastStudiedAt, 
    this.nextReviewAt,
  });

  TopicEntity copyWith({
    String? title,
    String? content,
    double? masteryScore,
    int? questionCount,
    int? estimatedReadTime,
    double? cognitiveDifficulty,
    DateTime? updatedAt,
    DateTime? lastStudiedAt,
    DateTime? nextReviewAt,
    bool? isFavorite,
    int? studyCount,
  }) {
    return TopicEntity(
      id: id,
      projectId: projectId,
      title: title ?? this.title,
      content: content ?? this.content,
      masteryScore: masteryScore ?? this.masteryScore,
      questionCount: questionCount ?? this.questionCount,
      estimatedReadTime:
          estimatedReadTime ?? this.estimatedReadTime,
      cognitiveDifficulty:
          cognitiveDifficulty ?? this.cognitiveDifficulty,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(), 
      isFavorite: isFavorite ?? this.isFavorite, 
      studyCount: studyCount ?? this.studyCount,
    );
  }
}
