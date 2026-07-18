import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

class ProjectCardEntity {
  final ProjectEntity project;
  final int dueTopics;
  final int daysSinceStudy;
  final String lastStudied;

  const ProjectCardEntity({
    required this.project, 
    required this.dueTopics, 
    required this.daysSinceStudy, 
    required this.lastStudied,
  });
}
