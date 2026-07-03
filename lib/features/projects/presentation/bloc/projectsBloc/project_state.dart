// States:
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

abstract class ProjectState {
  const ProjectState();
}

// ProjectInitial
class ProjectsInitialState extends ProjectState{
  const ProjectsInitialState();
}

// ProjectLoading
class ProjectsLoadingState extends ProjectState{
  const ProjectsLoadingState();
}

// ProjectsLoaded
class ProjectsLoadedState extends ProjectState{
  final List<ProjectEntity> projects;
  ProjectsLoadedState(this.projects);
}

// ProjectError
class ProjectsErrorState extends ProjectState{
  final String message;

  const ProjectsErrorState(this.message);
}
