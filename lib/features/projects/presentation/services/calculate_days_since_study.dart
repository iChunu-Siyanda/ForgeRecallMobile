import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

int calculateDaysSinceStudy(List<TopicEntity> topics) {
  final studied = topics
      .where((t) => t.lastStudiedAt != null)
      .toList();

  if (studied.isEmpty) return -1;

  studied.sort(
    (a, b) => b.lastStudiedAt!.compareTo(a.lastStudiedAt!),
  );

  final lastStudy = studied.first.lastStudiedAt!;

  return DateTime.now()
      .difference(lastStudy)
      .inDays;
}
