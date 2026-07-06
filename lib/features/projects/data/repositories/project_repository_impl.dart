import 'package:forge_recall/features/projects/data/model/project_model.dart';
import 'package:forge_recall/features/projects/data/datasources/project_remote_data_source.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource projectRemoteDataSource;
  ProjectRepositoryImpl(this.projectRemoteDataSource);

  @override
  Future<void> createProject(ProjectEntity project) async {
    final model = ProjectModel.fromEntity(project);
    await projectRemoteDataSource.createProject(model);
  }

  @override
  Future<void> updateProject(ProjectEntity project) async {
    final model = ProjectModel.fromEntity(project);
    return projectRemoteDataSource.updateProject(model);
  }

  @override
  Future<void> deleteProject(String projectId) async {
    await projectRemoteDataSource.deleteProject(projectId);
  }

  @override
  Future<ProjectEntity?> fetchProjectById(String projectId) async {
    return await projectRemoteDataSource.fetchProjectById(projectId);
  }

  @override
  Stream<List<ProjectEntity>> getProjects(String userId) {
    return projectRemoteDataSource.getProjects(userId);
  }
}
