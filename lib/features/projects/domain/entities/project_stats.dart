class ProjectStats {
  final double masteryPercentage;
  final int totalTopics;
  final int dueTopics;
  final int daysSinceStudy;
  final String lastStudied;

  const ProjectStats({
    required this.masteryPercentage, 
    required this.totalTopics,
    required this.lastStudied, 
    required this.dueTopics,
    required this.daysSinceStudy,
  });
}
