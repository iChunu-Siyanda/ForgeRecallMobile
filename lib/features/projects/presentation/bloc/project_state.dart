// States:
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

abstract class ProjectState {
  const ProjectState();
}

// ProjectInitial
class ProjectInitialState extends ProjectState{
  const ProjectInitialState();
}

// ProjectLoading
class ProjectLoadingState extends ProjectState{
  const ProjectLoadingState();
}

// ProjectsLoaded
class ProjectsLoadedState extends ProjectState{
  final List<ProjectEntity> projects;
  ProjectsLoadedState(this.projects);
}

//Project Loaded
class ProjectLoadedState extends ProjectState{
  final ProjectEntity project;
  ProjectLoadedState(this.project);
}

// ProjectError
class ProjectErrorState extends ProjectState{
  final String message;

  const ProjectErrorState(this.message);
}
