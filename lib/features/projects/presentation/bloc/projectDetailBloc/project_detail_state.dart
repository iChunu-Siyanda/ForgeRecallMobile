import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

abstract class ProjectDetailState {
  const ProjectDetailState();
}

// ProjectInitial
class ProjectInitialState extends ProjectDetailState{
  const ProjectInitialState();
}

// ProjectLoading
class ProjectLoadingState extends ProjectDetailState{
  const ProjectLoadingState();
}

//ProjectLoaded
class ProjectLoadedState extends ProjectDetailState{
  final ProjectEntity project;
  ProjectLoadedState(this.project);
}

// ProjectError
class ProjectErrorState extends ProjectDetailState{
  final String message;

  const ProjectErrorState(this.message);
}
