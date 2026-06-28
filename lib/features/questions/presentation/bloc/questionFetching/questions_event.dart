import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

abstract class QuestionsEvent {
  const QuestionsEvent();
}

class QuestionsLoadedEvent extends QuestionsEvent {
  final String projectId;
  final String topicId;

  QuestionsLoadedEvent(this.projectId,this.topicId);
}

class DeleteQuestionEvent extends QuestionsEvent {
  final String questionId;

  DeleteQuestionEvent(this.questionId);
}

class SaveQuestionsEvent extends QuestionsEvent {
  final String projectId;
  final String topicId;
  final List<QuestionEntity>? questions;

  SaveQuestionsEvent({
    required this.projectId,
    required this.topicId,
    this.questions,
  });
}

class AddQuestionEvent extends QuestionsEvent {
  final String projectId;
  final String topicId;
  final QuestionEntity question;

  AddQuestionEvent({
    required this.projectId,
    required this.topicId,
    required this.question,
  });

  // @override
  // List<Object> get props => [projectId, topicId, question];
}

class UpdateQuestionEvent extends QuestionsEvent {
  final QuestionEntity question;

  UpdateQuestionEvent(this.question);
}

class QuestionsUpdatedEvent extends QuestionsEvent {
  final List<QuestionEntity> questions;

  QuestionsUpdatedEvent(this.questions);
}

class QuestionsErrorEvent extends QuestionsEvent {
  final String message;

  QuestionsErrorEvent(this.message);
}
