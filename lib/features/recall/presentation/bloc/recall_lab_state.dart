import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

abstract class RecallLabState {
  const RecallLabState();
}

class RecallLabInitial extends RecallLabState {}

class RecallLabLoaded extends RecallLabState {
  final List<QuestionEntity> questions;
  final int currentIndex;
  final bool answerRevealed;
  final int forgotCount;
  final int partialCount;
  final int easyCount;

  const RecallLabLoaded({
    required this.questions,
    required this.currentIndex,
    required this.answerRevealed,
    required this.forgotCount,
    required this.partialCount,
    required this.easyCount,
  });

  QuestionEntity get currentQuestion => questions[currentIndex];

  bool get isLastQuestion => currentIndex == questions.length - 1;
}

class RecallLabCompleted extends RecallLabState {
  final int totalQuestions;
  final int forgotCount;
  final int partialCount;
  final int easyCount;

  const RecallLabCompleted({
    required this.totalQuestions,
    required this.forgotCount,
    required this.partialCount,
    required this.easyCount,
  });
}