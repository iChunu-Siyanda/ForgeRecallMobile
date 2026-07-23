import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/shared/entites/topic_filter.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:forge_recall/features/analytics/domain/entities/analytics_time_frame.dart';
import 'package:forge_recall/features/analytics/domain/usecases/fetch_recall_sessions.dart';
import 'package:forge_recall/features/analytics/presentation/bloc/analytics_event.dart';
import 'package:forge_recall/features/analytics/presentation/bloc/analytics_state.dart';
import 'package:forge_recall/features/projects/domain/usercases/get_projects.dart';
import 'package:forge_recall/features/topics/domain/usercases/get_topics.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetTopicsUseCase getAllTopics;
  final GetProjects getAllProjects;
  final FetchRecallSessions getAllSessions;
  final String userId;

  AnalyticsBloc({
    required this.getAllTopics, 
    required this.getAllProjects,
    required this.getAllSessions,
    required this.userId,
  }) : super(const AnalyticsInitial()) {
    on<FetchAnalyticsData>(_onFetchAnalyticsData);
    on<RefreshAnalyticsData>(_onRefreshAnalyticsData);
    on<ChangeAnalyticsTimeframe>(_onChangeAnalyticsTimeframe);
  }

  Future<void> _onFetchAnalyticsData(
    FetchAnalyticsData event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(const AnalyticsLoading());

    try {
      final topics = await getAllTopics(TopicQuery(filter: TopicFilter.allTopics),).first;
      final projectCards = await getAllProjects(userId).first;
      final sessions = await getAllSessions(userId,event.projectId!).first;

      emit(
        AnalyticsLoaded(
          topics: topics,
          projectCards: projectCards,
          sessions: sessions,
          selectedTimeframe: AnalyticsTimeframe.days7,
        ),
      );
    } catch (e) {
      emit(AnalyticsError(message: 'Failed to load analytics: ${e.toString()}'));
    }
  }

  //Pull-To-Refresh
Future<void> _onRefreshAnalyticsData(
    RefreshAnalyticsData event,
    Emitter<AnalyticsState> emit,
  ) async {
    final currentState = state;

    if (currentState is AnalyticsLoaded) {
      // 1. Set isRefreshing to true so RefreshIndicator / loading bar shows without wiping existing cards
      emit(currentState.copyWith(isRefreshing: true));

      try {
        // 2. Fetch fresh data from streams
        final topics = await getAllTopics(
          TopicQuery(filter: TopicFilter.allTopics),
        ).first;
        final projectCards = await getAllProjects(userId).first;
        final sessions = await getAllSessions(userId,event.projectId!).first;

        // 3. Emit updated state with new data, preserving selectedTimeframe, and setting isRefreshing back to false
        emit(
          currentState.copyWith(
            topics: topics,
            projectCards: projectCards,
            sessions: sessions,
            isRefreshing: false,
          ),
        );
      } catch (e) {
        // If refresh fails, turn off refreshing spinner but keep the existing data visible
        emit(currentState.copyWith(isRefreshing: false));
      }
    } else {
      add(const FetchAnalyticsData());
    }
  }
  //Filter/Timeframe Switching (7 Days / 30 Days / All Time)
  void _onChangeAnalyticsTimeframe(
    ChangeAnalyticsTimeframe event,
    Emitter<AnalyticsState> emit,
  ) {
    final currentState = state;
    if (currentState is AnalyticsLoaded) {
      if (currentState.selectedTimeframe == event.timeframe) return;

      emit(currentState.copyWith(selectedTimeframe: event.timeframe));
    }
  }
}
