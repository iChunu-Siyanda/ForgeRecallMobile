import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/router.dart';
import 'package:forge_recall/features/projects/data/repositories/project_remote_data_source_impl.dart';
import 'package:forge_recall/features/projects/data/repositories/project_repository_impl.dart';
import 'package:forge_recall/features/projects/domain/usercases/create_project.dart';
import 'package:forge_recall/features/projects/domain/usercases/delete_project.dart';
import 'package:forge_recall/features/projects/domain/usercases/fetch_project_by_id.dart.dart';
import 'package:forge_recall/features/projects/domain/usercases/get_projects.dart';
import 'package:forge_recall/features/projects/domain/usercases/update_project.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        final firestore = FirebaseFirestore.instance;
        final datasource = ProjectRemoteDataSourceImpl(firestore);
        final projectRepository = ProjectRepositoryImpl(datasource);
        final createProject = CreateProject(projectRepository);
        final updateProject = UpdateProject(projectRepository);
        final deleteProject = DeleteProject(projectRepository);
        final getProjects = GetProjects(projectRepository);
        final getSingleProject = FetchProjectById(projectRepository);
        
        return BlocProvider(
          create: (_) => ProjectBloc.name(
            createProject: createProject,
            updateProject: updateProject,
            deleteProject: deleteProject, 
            getProjects: getProjects,
            getSingleProject: getSingleProject,
          ),
          child: child!,
        );
      },
    );
  }
}
