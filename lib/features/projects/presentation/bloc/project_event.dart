// Events:
import 'package:forge_recall/features/projects/domain/entities/create_project_params.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

abstract class ProjectEvent {
  const ProjectEvent();
}

// CreateProject
class CreateProjectEvent extends ProjectEvent {
  final CreateProjectParams projectParams;
  CreateProjectEvent(this.projectParams);
}

// UpdateProject
class UpdateProjectEvent extends ProjectEvent {
  final ProjectEntity project;

  UpdateProjectEvent(this.project);
}

// LoadProjects
class LoadProjectsEvent extends ProjectEvent {
  final String userId;

  LoadProjectsEvent(this.userId);
}

// DeleteProject
class DeleteProjectEvent extends ProjectEvent {
  final String projectId;

  DeleteProjectEvent(this.projectId);
}

