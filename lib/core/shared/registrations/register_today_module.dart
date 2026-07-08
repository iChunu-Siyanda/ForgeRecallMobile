import 'package:forge_recall/features/today/domain/usecase/get_today_dashboard_use_case.dart';
import 'package:forge_recall/features/today/presentation/bloc/today_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerTodayModule() {
  getIt.registerLazySingleton(
    () => GetTodayDashboardUseCase(getIt(),),
  );

  getIt.registerFactory(
    () => TodayBloc(getIt(),),
  );
}
