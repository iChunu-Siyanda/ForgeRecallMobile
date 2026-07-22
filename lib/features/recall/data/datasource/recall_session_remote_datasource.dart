import 'package:forge_recall/features/recall/data/model/recall_session_modal.dart';

abstract class RecallSessionRemoteDatasource {
  Future<void> saveSession(RecallSessionModel session);

  Stream<List<RecallSessionModel>> getSessions({
    required String userId,
    String? projectId,
  });
}
