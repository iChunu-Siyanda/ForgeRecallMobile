import 'package:equatable/equatable.dart';
import 'package:forge_recall/features/analytics/domain/entities/analytics_time_frame.dart';
import 'package:forge_recall/features/projects/domain/entities/project_card_entity.dart';
import 'package:forge_recall/features/recall/domain/entities/recall_session_entity.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

sealed class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial();
}

class AnalyticsLoading extends AnalyticsState {
  const AnalyticsLoading();
}

class AnalyticsLoaded extends AnalyticsState {
  final List<TopicEntity> topics;
  final List<ProjectCardEntity> projectCards;
  final List<RecallSessionEntity> sessions;
  final AnalyticsTimeframe selectedTimeframe;
  final bool isRefreshing;

  const AnalyticsLoaded({
    required this.topics,
    required this.projectCards,
    required this.sessions,
    this.selectedTimeframe = AnalyticsTimeframe.days7,
    this.isRefreshing = false,
  });

  int get totalDueTopics => topics.where((t) {
    if (t.nextReviewAt == null) return false;
    return t.nextReviewAt!.isBefore(DateTime.now());
  }).length;

  double get avgMastery => topics.isEmpty
      ? 0.0
      : topics.map((t) => t.masteryScore).reduce((a, b) => a + b) / topics.length;

  double get avgDifficulty => topics.isEmpty
      ? 0.0
      : topics.map((t) => t.cognitiveDifficulty).reduce((a, b) => a + b) / topics.length;

  int get totalQuestions => topics.fold<int>(
    0,
    (sum, item) => sum + item.questionCount,
  );

  // Low mastery topics (<65%) sorted ascending by mastery score
  List<TopicEntity> get needsAttentionTopics =>
      topics.where((t) => t.masteryScore < 65.0).toList()
        ..sort((a, b) => a.masteryScore.compareTo(b.masteryScore));

  AnalyticsLoaded copyWith({
    List<TopicEntity>? topics,
    List<ProjectCardEntity>? projectCards,
    List<RecallSessionEntity>? sessions,
    AnalyticsTimeframe? selectedTimeframe,
    bool? isRefreshing,
  }) {
    return AnalyticsLoaded(
      topics: topics ?? this.topics,
      projectCards: projectCards ?? this.projectCards,
      sessions: sessions ?? this.sessions,
      selectedTimeframe: selectedTimeframe ?? this.selectedTimeframe,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        topics,
        projectCards,
        //sessions,
        selectedTimeframe,
        isRefreshing,
      ];
}

class AnalyticsError extends AnalyticsState {
  final String message;

  const AnalyticsError({required this.message});

  @override
  List<Object?> get props => [message];
}
