import 'package:forge_recall/features/recall/domain/entities/recall_session_entity.dart';
import 'package:forge_recall/features/recall/domain/repositories/recall_session_repository.dart';

class FetchRecallSessions {
  final RecallSessionRepository repository;
  const FetchRecallSessions(this.repository);

  Stream<List<RecallSessionEntity>> call(
    String userId,
    String? projectId,
  ){
    return repository.getSessions(
      userId: userId, 
      projectId: projectId!,
    );
  }
}
