import 'package:forge_recall/features/recall/data/model/recall_session_modal.dart';
import 'package:forge_recall/features/recall/data/repositories/recall_session_remote_datasource.dart';
import 'package:forge_recall/features/recall/domain/entities/recall_session_entity.dart';
import 'package:forge_recall/features/recall/domain/repositories/recall_session_repository.dart';

class RecallSessionRepositoryImpl implements RecallSessionRepository{
  final RecallSessionRemoteDatasourceImpl repository;
  RecallSessionRepositoryImpl(this.repository);

  @override
  Stream<List<RecallSessionEntity>> getSessions({required String userId, String? projectId}) {
    return repository.getSessions(userId: userId);
  }

  @override
  Future<void> saveSession(RecallSessionEntity session) {
    final model = RecallSessionModel.fromEntity(session);
    return repository.saveSession(model);
  }
}
