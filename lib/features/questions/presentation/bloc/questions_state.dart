import 'package:forge_recall/features/questions/domain/entities/topics_questions_entity.dart';

abstract class QuestionsState {
  const QuestionsState();
}

class QuestionsInitial extends QuestionsState {
  const QuestionsInitial();
}

class QuestionsLoading extends QuestionsState {
  const QuestionsLoading();
}

class QuestionsLoaded extends QuestionsState {
  final TopicQuestionsEntity topicQuestions;

  QuestionsLoaded(this.topicQuestions);
}

class QuestionsError extends QuestionsState {
  final String message;

  QuestionsError(this.message);
}