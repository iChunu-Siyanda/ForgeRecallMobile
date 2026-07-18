import 'dart:ui';

import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

class ProjectCardEntity {
  final ProjectEntity project;
  final double masteryPercentage;
  final int totalTopics;
  final int dueTopics;
  final int daysSinceStudy;
  final String lastStudied;

  const ProjectCardEntity({
    required this.project, 
    required this.masteryPercentage, 
    required this.totalTopics,
    required this.dueTopics, 
    required this.daysSinceStudy, 
    required this.lastStudied, 
  });

  Color get getProjectAccent {
    if (masteryPercentage >= 80) return AppColours.emerald;
    if (masteryPercentage >= 60) return AppColours.electricBlue;
    if (masteryPercentage >= 40) return AppColours.amber;
    return AppColours.crimson;
  }
}
