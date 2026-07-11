import 'package:forge_recall/core/shared/entites/topic_filter.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:forge_recall/features/today/domain/entities/today_dashboard.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetTodayDashboardUseCase {
  final TopicRepository topicRepository;
  GetTodayDashboardUseCase(this.topicRepository);

  Stream<TodayDashboard> call() {
    final recentTopics = topicRepository.getTopics(
      const TopicQuery(
        filter: TopicFilter.recent,
      ),
    );

    final difficultTopics = topicRepository.getTopics(
      const TopicQuery(
        filter: TopicFilter.difficult,
      ),
    );

    final completedTopics = topicRepository.getTopics(
      const TopicQuery(
        filter: TopicFilter.completed,
      ),
    );

    return Rx.combineLatest3(
      recentTopics,
      difficultTopics,
      completedTopics,
      (
        recent,
        difficult,
        completed,
      ) {
        return TodayDashboard(
          continueTopic: recent.isEmpty ? null : recent.first,
          dueTopics: const [],
          recommendedTopics: difficult.take(3).toList(),
          questionsAnsweredToday: 0,
          minutesStudiedToday: 0,
          topicsCompletedToday: completed.length,
          dailyProgress: 0,
        );
      },
    );
  }
}
