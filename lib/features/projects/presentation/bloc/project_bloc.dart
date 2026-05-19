import 'package:forge_recall/features/projects/domain/usercases/create_project.dart';
import 'package:forge_recall/features/projects/domain/usercases/delete_project.dart';
import 'package:forge_recall/features/projects/domain/usercases/get_projects.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_event.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final CreateProject createProject;
  final GetProjects getProjects;
  final DeleteProject deleteProject;

  ProjectBloc({
    required this.createProject,
    required this.getProjects,
    required this.deleteProject,
  }) : super(ProjectInitialState()) {
    on<LoadProjectsEvent>(_onLoadProjects);
    on<CreateProjectEvent>(_onCreateProject);
    on<DeleteProjectEvent>(_onDeleteProject);
  }

  Future<void> _onLoadProjects(
    LoadProjectsEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoadingState());

    await emit.forEach(
      getProjects(event.userId),
      onData: (projects) => ProjectLoadedState(projects),
      onError: (_, _) => ProjectErrorState('Failed to load projects'),
    );
  }

  Future<void> _onCreateProject(
    CreateProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      await createProject(event.project);
    } catch (e) {
      emit(ProjectErrorState(e.toString()));
    }
  }

   Future<void> _onDeleteProject(
    DeleteProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      await deleteProject(event.projectId);
    } catch (e) {
      emit(ProjectErrorState(e.toString()));
    }
  }
}
