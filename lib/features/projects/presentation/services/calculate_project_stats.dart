import 'package:forge_recall/features/projects/domain/entities/project_stats.dart';
import 'package:forge_recall/features/projects/presentation/services/calculate_days_since_study.dart';
import 'package:forge_recall/features/projects/presentation/services/calculate_due.dart';
import 'package:forge_recall/features/projects/presentation/services/calculate_last_studied.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class CalculateProjectStats {
  static ProjectStats calculateStatistics(
    List<TopicEntity> topic,
  ) {
    final due = calculateDue(topic);
    final days = calculateDaysSinceStudy(topic);

    return ProjectStats(
      dueTopics: due,
      daysSinceStudy: days,
      lastStudied: calculateLastStudied(topic),
    );
  }
}
