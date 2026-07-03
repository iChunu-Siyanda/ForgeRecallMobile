import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/domain/usercases/create_project.dart';
import 'package:forge_recall/features/projects/domain/usercases/delete_project.dart';
import 'package:forge_recall/features/projects/domain/usercases/get_projects.dart';
import 'package:forge_recall/features/projects/domain/usercases/update_project.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_event.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final CreateProject createProject;
  final GetProjects getProjects;
  final DeleteProject deleteProject;
  final UpdateProject updateProject;

  ProjectBloc.name({
    required this.createProject,
    required this.getProjects,
    required this.deleteProject,
    required this.updateProject,
  }) : super(ProjectsInitialState()) {
    on<LoadProjectsEvent>(_onLoadProjects);
    on<CreateProjectEvent>(_onCreateProject);
    on<UpdateProjectEvent>(_onUpdateProject);
    on<DeleteProjectEvent>(_onDeleteProject);
  }

  Future<void> _onLoadProjects(
    LoadProjectsEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectsLoadingState());

    await emit.forEach(
      getProjects(event.userId),
      onData: (projects) => ProjectsLoadedState(projects),
      onError: (error, stackTrace) {
        debugPrint('ProjectBloc getProjects FIREBASE ERROR: $error'); 
        return ProjectsErrorState(error.toString()); 
      },
    );
  }

  Future<void> _onCreateProject(
    CreateProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      await createProject(event.projectParams);
    } catch (e) {
      emit(ProjectsErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateProject(
    UpdateProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      await updateProject(event.project);
    } catch (e) {
      emit(ProjectsErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteProject(
    DeleteProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      await deleteProject(event.projectId);
    } catch (e) {
      emit(ProjectsErrorState(e.toString()));
    }
  }
}
