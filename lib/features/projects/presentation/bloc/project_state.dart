// States:
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
 //requirements

  const ProjectLoadedState();
}

// ProjectError
class ProjectErrorState extends ProjectState{
  final String msg;

  const ProjectErrorState(this.msg);
}
