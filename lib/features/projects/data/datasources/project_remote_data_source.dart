import 'package:forge_recall/features/projects/data/model/project_model.dart';

abstract class ProjectRemoteDataSource {
  Future<void> createProject(ProjectModel project);

  Future<void> updateProject(ProjectModel project);

  Future<void> deleteProject(String projectId);

  Stream<List<ProjectModel>> getProjects(String userId);

  Future<ProjectModel?> fetchProjectById(String projectId);
}