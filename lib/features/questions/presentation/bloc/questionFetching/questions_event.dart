abstract class QuestionsEvent {
  const QuestionsEvent();
}

class QuestionsLoadedEvent extends QuestionsEvent {
  final String projectId;
  final String topicId;

  QuestionsLoadedEvent(this.projectId,this.topicId);
}