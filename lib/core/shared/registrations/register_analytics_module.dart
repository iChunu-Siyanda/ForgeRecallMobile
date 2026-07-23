import 'package:forge_recall/features/analytics/domain/usecases/fetch_recall_sessions.dart';
import 'package:forge_recall/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerAnalyticsModule() {
  getIt.registerLazySingleton(
    () => FetchRecallSessions(getIt(),),
  );

  getIt.registerFactoryParam<AnalyticsBloc, String, void>(
    (userId,_) => AnalyticsBloc(
      getAllTopics: getIt(), 
      getAllProjects: getIt(), 
      getAllSessions: getIt(),
      userId: userId, 
    ),
  );
}
