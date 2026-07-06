import 'package:forge_recall/features/projects/domain/usercases/fetch_project_by_id.dart.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectDetailBloc/project_detail_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerProjectDetailModule() {
  //Datasource
  // getIt.registerLazySingleton<ProjectRemoteDataSource>(//
  //   () => ProjectRemoteDataSourceImpl(getIt(),),
  // );

  // //Repository
  // getIt.registerLazySingleton<ProjectRepository>(
  //   () => ProjectRepositoryImpl(getIt(),),
  // );

  //Usercase
  getIt.registerLazySingleton(
    () => FetchProjectById(getIt(),),
  );

  //Bloc
  getIt.registerFactory(
    () => ProjectDetailBloc(getIt()),
  );
}
