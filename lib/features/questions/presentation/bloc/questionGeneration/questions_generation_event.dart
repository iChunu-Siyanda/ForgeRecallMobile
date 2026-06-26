import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

abstract class QuestionsGenerationEvent {}

class GenerateQuestionsEvent extends QuestionsGenerationEvent {
  final String notes;

  GenerateQuestionsEvent(this.notes);
}

class AddQuestionEvent extends QuestionsGenerationEvent {
  final QuestionEntity question;

  AddQuestionEvent(this.question);
}

class UpdateQuestionEvent extends QuestionsGenerationEvent {
  final QuestionEntity question;

  UpdateQuestionEvent(this.question);
}

class DeleteQuestionEvent extends QuestionsGenerationEvent {
  final String questionId;

  DeleteQuestionEvent(this.questionId);
}

class SaveQuestionsEvent extends QuestionsGenerationEvent {
  final String projectId;
  final String topicId;
  final List<QuestionEntity>? questions;

  SaveQuestionsEvent({
    required this.projectId,
    required this.topicId,
    this.questions,
  });
}
