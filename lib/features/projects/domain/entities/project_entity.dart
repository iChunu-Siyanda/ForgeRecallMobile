import 'dart:ui';
import 'package:forge_recall/core/theme/app_colours.dart';

class ProjectEntity{
  final String id;
  final String title;
  final String description;
  final double masteryPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int totalQuestions;
  final int totalTopics;
  final String userId; 

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.masteryPercentage,
    required this.createdAt,
    required this.updatedAt,
    required this.totalQuestions,
    required this.totalTopics,
    required this.userId,
  });

  Color get getProjectAccent {
    if (masteryPercentage >= 80) return AppColours.emerald;
    if (masteryPercentage >= 60) return AppColours.electricBlue;
    if (masteryPercentage >= 40) return AppColours.amber;
    return AppColours.crimson;
  }
}
