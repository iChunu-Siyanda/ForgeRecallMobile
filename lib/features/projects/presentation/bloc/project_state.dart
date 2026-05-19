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

// ProjectLoaded
class ProjectLoadedState extends ProjectState{
  final List<ProjectEntity> projects;
  ProjectLoadedState(this.projects);
}

// ProjectError
class ProjectErrorState extends ProjectState{
  final String msg;

  const ProjectErrorState(this.msg);
}
