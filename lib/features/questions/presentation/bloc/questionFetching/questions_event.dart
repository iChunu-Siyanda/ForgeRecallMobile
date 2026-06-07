abstract class QuestionsEvent {
  const QuestionsEvent();
}

abstract class QuestionsLoadedEvent extends QuestionsEvent {
  final String questionsId;
  final String topicId;
  final String projectId;

  QuestionsLoadedEvent(this.questionsId, this.topicId, this.projectId,);
}