import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class TodayDashboard {
  final TopicEntity? continueTopic;
  final List<TopicEntity> dueTopics;
  final List<TopicEntity> recommendedTopics;
  final int questionsAnsweredToday;
  final int minutesStudiedToday;
  final int topicsCompletedToday;
  final double dailyProgress;

  const TodayDashboard({
    required this.continueTopic,
    required this.dueTopics,
    required this.recommendedTopics,
    required this.questionsAnsweredToday,
    required this.minutesStudiedToday,
    required this.topicsCompletedToday,
    required this.dailyProgress,
  });
}
