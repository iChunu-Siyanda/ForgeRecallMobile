import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';

class CreateProject {
  final ProjectRepository repository;
  CreateProject(this.repository);

   Future<void> call(ProjectEntity project) async {
    await repository.createProject(project);
  }
}