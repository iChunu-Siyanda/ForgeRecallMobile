import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';

class FetchProjectById {
  final ProjectRepository repository;
  FetchProjectById(this.repository);

  Future<void> call(String projectId) async {
    await repository.fetchProjectById(projectId);
  }
}