import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository{
  //final ProjectData localProjectData or projectData;
  //ProjectRespositoryImpl(this.localProjectData);

  @override
  Future<void> createProject(ProjectEntity project) {
    // TODO: implement createProject
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProject(String projectId) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Future<ProjectEntity?> fetchProjectById(String projectId) {
    // TODO: implement fetchProjectById
    throw UnimplementedError();
  }

  @override
  Stream<List<ProjectEntity>> getProjects(String userId) {
    // TODO: implement getProjects
    throw UnimplementedError();
  }

  @override
  Future<void> updateProject(ProjectEntity project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }
}