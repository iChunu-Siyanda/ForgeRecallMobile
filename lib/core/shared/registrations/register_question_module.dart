import 'package:forge_recall/features/questions/data/datasource/questions_remote_datasource.dart';
import 'package:forge_recall/features/questions/data/repositories/questions_remote_datasource_impl.dart';
import 'package:forge_recall/features/questions/data/repositories/questions_repository_impl.dart';
import 'package:forge_recall/features/questions/domain/repositories/questions_repository.dart';
import 'package:forge_recall/features/questions/domain/usecases/get_topics_questions_user_case.dart';
import 'package:forge_recall/features/questions/domain/usecases/save_questions_use_case.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerQuestionModule() {

  // Datasource
  getIt.registerLazySingleton<QuestionsRemoteDatasource>(
    () => QuestionsRemoteDatasourceImpl(getIt(),),
  );

  // Repository
  getIt.registerLazySingleton<QuestionsRepository>(
    () => QuestionsRepositoryImpl(getIt(),),
  );

  // UseCases
  getIt.registerLazySingleton(
    () => SaveQuestionsUseCase(getIt<QuestionsRepository>(),),
  );

  getIt.registerLazySingleton(
    () => GetTopicsQuestionsUseCase(getIt<QuestionsRepository>(),),
  );

  // Bloc
  getIt.registerFactory(
    () => QuestionsBloc(
      getIt(),
      getIt(),
    ),
  );
}
