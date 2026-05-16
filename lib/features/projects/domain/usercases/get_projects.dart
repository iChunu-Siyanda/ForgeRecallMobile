import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';

abstract class GetProjects {
  final ProjectRepository respository;
  GetProjects(this.respository);

  Future<void> call(String userId) async {
    respository.getProjects(userId);
  }
}