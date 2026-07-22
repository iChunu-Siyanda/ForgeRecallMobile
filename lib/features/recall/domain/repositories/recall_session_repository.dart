import 'package:forge_recall/features/recall/domain/entities/recall_session_entity.dart';

abstract class RecallSessionRepository {
  Future<void> saveSession(RecallSessionEntity session);

  Stream<List<RecallSessionEntity>> getSessions({
    required String userId,
    String? projectId,
  });
}
