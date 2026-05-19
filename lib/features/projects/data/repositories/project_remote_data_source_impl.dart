import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/projects/data/model/project_model.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_remote_data_source.dart';

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final FirebaseFirestore firestore;
  ProjectRemoteDataSourceImpl(this.firestore);

  final projectsCollection = FirebaseFirestore.instance.collection('projects');

  @override
  Future<void> createProject(ProjectModel project) async {
    await projectsCollection.doc(project.id).set(project.toJson());
  }

  @override
  Future<void> updateProject(ProjectModel project) async {
    await projectsCollection.doc(project.id).update(project.toJson());
  }

  @override
  Future<void> deleteProject(String projectId) async {
    await projectsCollection.doc(projectId).delete();
  }

  @override
  Stream<List<ProjectModel>> getProjects(String userId) {
    return projectsCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProjectModel.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<ProjectModel?> fetchProjectById(String projectId) async {
    final doc = await projectsCollection.doc(projectId).get();

    if (!doc.exists) return null;

    return ProjectModel.fromJson(doc.data()!);
  }
}
