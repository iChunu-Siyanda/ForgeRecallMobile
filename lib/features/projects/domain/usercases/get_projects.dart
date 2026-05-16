import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';

abstract class GetProjects {
  final ProjectRepository respository;
  GetProjects(this.respository);

  Stream<List<ProjectEntity>> call(String userId) {
    return respository.getProjects(userId);
  }
}