import 'package:forge_recall/features/search/domain/usecases/search_topic_use_case.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerSearchModule() {
  getIt.registerLazySingleton(
    () => SearchTopicsUseCase(getIt(),),
  );

  getIt.registerFactory(
    () => SearchBloc(searchTopic: getIt(),),
  );
}
