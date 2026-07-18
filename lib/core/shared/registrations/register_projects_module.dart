import 'package:forge_recall/features/projects/data/datasources/project_remote_data_source.dart';
import 'package:forge_recall/features/projects/data/repositories/project_remote_data_source_impl.dart';
import 'package:forge_recall/features/projects/data/repositories/project_repository_impl.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';
import 'package:forge_recall/features/projects/domain/usercases/create_project.dart';
import 'package:forge_recall/features/projects/domain/usercases/delete_project.dart';
import 'package:forge_recall/features/projects/domain/usercases/get_projects.dart';
import 'package:forge_recall/features/projects/domain/usercases/update_project.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerProjectsModule() {
  //final datasource = ProjectRemoteDataSourceImpl(firestore);
  getIt.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(getIt(),),
  );

  //final projectRepository = ProjectRepositoryImpl(datasource);
  getIt.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(getIt(),),
  );

  //final createProject = CreateProject(projectRepository);
  getIt.registerLazySingleton(
    () => CreateProject(getIt(),),
  );

  //final updateProject = UpdateProject(projectRepository);
  getIt.registerLazySingleton(
    () => UpdateProject(getIt(),),
  );

  //final deleteProject = DeleteProject(projectRepository);
  getIt.registerLazySingleton(
    () => DeleteProject(getIt(),),
  );

  //final getProjects = GetProjects(projectRepository);
  getIt.registerLazySingleton(
    () => GetProjects(
      projectRepository: getIt(), 
      topicRepository: getIt(), 
    ),
  );

  //ProjectsBloc
  getIt.registerFactory(
    () => ProjectBloc.name(
      createProject: getIt(), 
      getProjects: getIt(), 
      deleteProject: getIt(), 
      updateProject: getIt(),
    ),
  );
}
