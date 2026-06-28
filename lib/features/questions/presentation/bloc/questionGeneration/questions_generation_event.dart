abstract class QuestionsGenerationEvent {}

class GenerateQuestionsEvent extends QuestionsGenerationEvent {
  final String notes;

  GenerateQuestionsEvent(this.notes);
}
