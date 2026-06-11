import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

abstract class QuestionsState {
  const QuestionsState();
}

class QuestionsInitialState extends QuestionsState {
  const QuestionsInitialState();
}

class QuestionsLoadingState extends QuestionsState {
  const QuestionsLoadingState();
}

class QuestionsLoadedState extends QuestionsState {
  final List<QuestionEntity> topicQuestions;

  QuestionsLoadedState(this.topicQuestions);
}

class QuestionsErrorState extends QuestionsState {
  final String message;

  QuestionsErrorState(this.message);
}