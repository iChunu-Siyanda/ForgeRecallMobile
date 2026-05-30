import 'package:firebase_auth/firebase_auth.dart';
import 'package:forge_recall/features/projects/domain/entities/create_project_params.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:uuid/uuid.dart';

class CreateProject {
  final ProjectRepository repository;
  CreateProject(this.repository);

  Future<void> call(
    CreateProjectParams params,
  ) async {
    User? currentUserId = FirebaseAuth.instance.currentUser!;
    final project = ProjectEntity(
      id: const Uuid().v4(),
      title: params.title,
      description: params.description,
      masteryPercentage: 0,
      totalTopics: 0,
      totalQuestions: 0,
      userId: currentUserId.uid,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await repository.createProject(project);
  }
}