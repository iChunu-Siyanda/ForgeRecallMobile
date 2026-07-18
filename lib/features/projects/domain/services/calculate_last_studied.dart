import 'package:forge_recall/features/projects/domain/services/calculate_days_since_study.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

String calculateLastStudied(List<TopicEntity> topics) {
  final days = calculateDaysSinceStudy(topics);

  if (days == -1) return 'Never studied';

  if (days == 0) return 'Studied today';

  if (days == 1) return 'Studied yesterday';

  return 'Not studied for $days days';
}
