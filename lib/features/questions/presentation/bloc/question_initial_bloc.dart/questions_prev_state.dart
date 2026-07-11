import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

abstract class QuestionsPrevState {
  const QuestionsPrevState();
}

class QuestionsPrevInitial extends QuestionsPrevState {
  const QuestionsPrevInitial();
}

class QuestionsPrevLoading extends QuestionsPrevState {
  const QuestionsPrevLoading();
}

class QuestionsPrevLoaded extends QuestionsPrevState {
  final List<QuestionEntity> topicQuestions;

  QuestionsPrevLoaded(this.topicQuestions);
}

class QuestionsPrevError extends QuestionsPrevState {
  final String message;

  QuestionsPrevError(this.message);
}
