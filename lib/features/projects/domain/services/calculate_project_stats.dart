import 'package:forge_recall/features/projects/domain/entities/project_stats.dart';
import 'package:forge_recall/features/projects/domain/services/calculate_days_since_study.dart';
import 'package:forge_recall/features/projects/domain/services/calculate_due.dart';
import 'package:forge_recall/features/projects/domain/services/calculate_last_studied.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class CalculateProjectStats {
  static ProjectStats calculateStatistics(
    List<TopicEntity> topics,
  ) {
    final totalTopics = topics.length;
    final double mastery = totalTopics == 0 
                        ? 0 
                        : topics.map((t) => t.masteryScore).reduce((a,b) => a + b);
    final due = calculateDue(topics);
    final days = calculateDaysSinceStudy(topics);

    return ProjectStats(
      masteryPercentage: mastery, 
      totalTopics: totalTopics,
      dueTopics: due,
      daysSinceStudy: days,
      lastStudied: calculateLastStudied(topics),
    );
  }
}
