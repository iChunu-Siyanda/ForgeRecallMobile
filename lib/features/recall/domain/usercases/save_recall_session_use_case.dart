import 'package:forge_recall/features/recall/domain/entities/recall_session_entity.dart';
import 'package:forge_recall/features/recall/domain/repositories/recall_session_repository.dart';

class SaveRecallSessionUseCase {
  final RecallSessionRepository repository;

  const SaveRecallSessionUseCase(this.repository);

  Future<void> call(RecallSessionEntity session) {
    return repository.saveSession(session);
  }

//   double get questionsPerMinute =>
//     durationSeconds == 0
//         ? 0
//         : totalQuestions / (durationSeconds / 60);

// double get averageSecondsPerQuestion =>
//     totalQuestions == 0
//         ? 0
//         : durationSeconds / totalQuestions;
}
