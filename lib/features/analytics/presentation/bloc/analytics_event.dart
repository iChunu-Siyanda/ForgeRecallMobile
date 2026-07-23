import 'package:equatable/equatable.dart';
import 'package:forge_recall/features/analytics/domain/entities/analytics_time_frame.dart';

sealed class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAnalyticsData extends AnalyticsEvent {
  final String? projectId;

  const FetchAnalyticsData({this.projectId});
}

class RefreshAnalyticsData extends AnalyticsEvent {
  final String? projectId;

  const RefreshAnalyticsData({this.projectId});
}

//When the user taps on '7 Days', '30 Days', or 'All Time'
class ChangeAnalyticsTimeframe extends AnalyticsEvent {
  final AnalyticsTimeframe timeframe;

  const ChangeAnalyticsTimeframe(this.timeframe);

  @override
  List<Object?> get props => [timeframe];
}
