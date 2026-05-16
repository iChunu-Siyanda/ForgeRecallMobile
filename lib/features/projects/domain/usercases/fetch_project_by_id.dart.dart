import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';

class FetchProjectById {
  final ProjectRepository repository;
  FetchProjectById(this.repository);

  Future<ProjectEntity?> call(String projectId) async {
    return await repository.fetchProjectById(projectId);
  }
}