import 'package:forge_recall/features/projects/data/datasources/project_remote_data_source.dart';
import 'package:forge_recall/features/projects/data/repositories/project_remote_data_source_impl.dart';
import 'package:forge_recall/features/projects/data/repositories/project_repository_impl.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectDetailBloc/project_detail_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectDetailBloc/project_detail_event.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerProjectDetailModule() {
  //Datasource
  getIt.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(getIt(),),
  );

  //Repository
  getIt.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(getIt(),),
  );

  //Usercase
  getIt.registerLazySingleton(
    () => GetSingleProjectEvent(getIt()),
  );

  //Bloc
  getIt.registerFactory(
    () => ProjectDetailBloc(getIt()),
  );
}
