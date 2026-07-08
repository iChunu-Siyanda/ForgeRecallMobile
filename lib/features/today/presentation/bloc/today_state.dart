import 'package:forge_recall/features/today/domain/entities/today_dashboard.dart';

sealed class TodayState {}

class TodayLoading extends TodayState {}

class TodayLoaded extends TodayState {
  final TodayDashboard dashboard;

  TodayLoaded(this.dashboard);
}

class TodayError extends TodayState {
  final String message;

  TodayError(this.message);
}
