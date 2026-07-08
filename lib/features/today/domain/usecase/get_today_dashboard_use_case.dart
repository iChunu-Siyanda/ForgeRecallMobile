import 'package:forge_recall/core/shared/entites/topic_filter.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:forge_recall/features/today/domain/entities/today_dashboard.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class GetTodayDashboardUseCase {
  final TopicRepository topicRepository;

  GetTodayDashboardUseCase(this.topicRepository);

  Stream<TodayDashboard> call() {
    return topicRepository
        .getTopics(
          const TopicQuery(
            filter: TopicFilter.recent,
          ),
        )
        .map((topics) {
          final continueTopic = topics.isNotEmpty ? topics.first : null;

          return TodayDashboard(
            continueTopic: continueTopic,
            dueTopics: const [],
            recommendedTopics: const [],
            questionsAnsweredToday: 0,
            minutesStudiedToday: 0,
            topicsCompletedToday: 0,
            dailyProgress: 0,
          );
        });
  }
}
