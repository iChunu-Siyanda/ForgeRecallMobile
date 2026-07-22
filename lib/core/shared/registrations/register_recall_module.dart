import 'package:forge_recall/features/recall/data/datasource/recall_session_remote_datasource.dart';
import 'package:forge_recall/features/recall/data/repositories/recall_session_remote_datasource.dart';
import 'package:forge_recall/features/recall/data/repositories/recall_session_repository_impl.dart';
import 'package:forge_recall/features/recall/domain/repositories/recall_session_repository.dart';
import 'package:forge_recall/features/recall/domain/usercases/save_recall_session_use_case.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerRecallModule() {
  getIt.registerLazySingleton<RecallSessionRemoteDatasource>(
    () => RecallSessionRemoteDatasourceImpl(getIt(),),
  );

  getIt.registerLazySingleton<RecallSessionRepository>(
    () => RecallSessionRepositoryImpl(getIt(),),
  );

  getIt.registerLazySingleton(
    () => SaveRecallSessionUseCase(getIt(),),
  );

  getIt.registerFactoryParam<RecallLabBloc, String, void>(
    (userId,_) => RecallLabBloc(
      userId: userId, 
      saveRecallSessionUseCase: getIt(),
    ),
  );
}
