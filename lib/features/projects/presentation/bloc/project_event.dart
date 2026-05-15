// Events:
abstract class ProjectEvent {
  const ProjectEvent();
}

// CreateProject
class CreateProjectEvent extends ProjectEvent {
  //requirements

  const CreateProjectEvent();
}

// LoadProjects
class LoadProjectsEvent extends ProjectEvent {
  //requirements

  const LoadProjectsEvent();
}

// DeleteProject
class DeleteProjectEvent extends ProjectEvent {
  //requirements

  const DeleteProjectEvent();
}

// UpdateProject
class UpdateProjectEvent extends ProjectEvent {
  //requirements

  const UpdateProjectEvent();
}
