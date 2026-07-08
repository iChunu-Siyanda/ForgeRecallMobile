import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/today/domain/usecase/get_today_dashboard_use_case.dart';
import 'package:forge_recall/features/today/presentation/bloc/today_event.dart';
import 'package:forge_recall/features/today/presentation/bloc/today_state.dart';

class TodayBloc extends Bloc<TodayEvent, TodayState> {
  final GetTodayDashboardUseCase getTodayDashboard;

  TodayBloc(this.getTodayDashboard) : super(TodayLoading()) {
    on<LoadToday>(_onLoadToday);
  }

  Future<void> _onLoadToday(
    LoadToday event,
    Emitter<TodayState> emit,
  ) async {
    emit(TodayLoading());

    await emit.forEach(
      getTodayDashboard(),
      onData: (dashboard) => TodayLoaded(dashboard),
      onError: (error, stackTrace) =>
          TodayError(error.toString()),
    );
  }
}
