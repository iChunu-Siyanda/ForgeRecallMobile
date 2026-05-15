class ProjectEntity{
  final String id;
  final String description;
  final double masteryPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> totalQuestions;
  final List<String> totalTopics;
  final String userId; 

  const ProjectEntity({
    required this.id,
    required this.description,
    required this.masteryPercentage,
    required this.createdAt,
    required this.updatedAt,
    required this.totalQuestions,
    required this.totalTopics,
    required this.userId,
  });
}
