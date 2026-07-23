import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

int calculateDue(List<TopicEntity> topics) {
  final now = DateTime.now();

  return topics.where((topic) {
    return topic.nextReviewAt != null && !topic.nextReviewAt!.isAfter(now);
  }).length;
}
