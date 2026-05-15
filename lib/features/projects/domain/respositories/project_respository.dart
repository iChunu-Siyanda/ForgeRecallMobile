import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

abstract class ProjectRespository {
  // Create project
  Future<void> createProject(ProjectEntity project);

  // Update project
  Future<void> updateProject(ProjectEntity project);

  // Delete project
  Future<void> deleteProject(String projectId);

  // Get all projects
  Stream<List<ProjectEntity>> getProjects(String userId);

  // Fetch project by id
  Future<ProjectEntity?> fetchProjectById(String projectId); 
}

// Because of Stream => your UI updates automatically when:
// projects added
// projects deleted
// projects updated
// Without manually refreshing.