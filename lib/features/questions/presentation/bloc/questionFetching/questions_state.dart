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

class QuestionsSaving extends QuestionsState {
    final List<QuestionEntity> questions;

  QuestionsSaving(this.questions);
}

class QuestionsSaveSuccess extends QuestionsState {}

class QuestionsErrorState extends QuestionsState {
  final String message;

  QuestionsErrorState(this.message);
}
