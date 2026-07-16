import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';

class GetProjects {
  final ProjectRepository repository;
  GetProjects(this.repository);

  Stream<List<ProjectEntity>> call(String userId) {
    return repository.getProjects(userId);
  }
}
