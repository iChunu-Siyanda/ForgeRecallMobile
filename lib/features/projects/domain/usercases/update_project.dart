import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';

class UpdateProject {
  final ProjectRepository repository;
  UpdateProject(this.repository);

  Future<void> call(ProjectEntity project) async {
    await repository.updateProject(project);
  }
}