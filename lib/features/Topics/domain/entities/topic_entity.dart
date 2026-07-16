class TopicEntity {
  final String id;
  final String projectId;
  final String title;
  final String titleLower;
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
    required this.titleLower,
    required this.content,
    required this.masteryScore,
    required this.questionCount,
    required this.estimatedReadTime,
    required this.cognitiveDifficulty,
    required this.createdAt,
    required this.updatedAt, 
    required this.isFavorite, 
    required this.studyCount,
    required this.lastStudiedAt, 
    this.nextReviewAt, 
  });

  TopicEntity copyWith({
    String? title,
    String? titleLower,
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
      titleLower: titleLower ?? this.titleLower,
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
      lastStudiedAt: lastStudiedAt ?? DateTime.now(), 
    );
  }
}
