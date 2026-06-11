import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

abstract class QuestionsGenerationState {}

class QuestionsInitial extends QuestionsGenerationState {}

class QuestionsLoading extends QuestionsGenerationState {}

class QuestionsLoaded extends QuestionsGenerationState {
  final List<QuestionEntity> questions;

  QuestionsLoaded(this.questions);
}

class QuestionsSaving extends QuestionsGenerationState {
    final List<QuestionEntity> questions;

  QuestionsSaving(this.questions);
}

class QuestionsSaveSuccess extends QuestionsGenerationState {}

class QuestionsError extends QuestionsGenerationState {
  final String message;

  QuestionsError(this.message);
}
