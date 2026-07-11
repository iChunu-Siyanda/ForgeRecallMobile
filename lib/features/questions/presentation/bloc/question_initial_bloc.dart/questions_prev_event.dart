//Prev means preview
sealed class QuestionsPrevEvent {
  const QuestionsPrevEvent();
}

class QuestionsContentLoaded extends QuestionsPrevEvent {
  final String projectId;
  final String topicId;

  QuestionsContentLoaded(this.projectId,this.topicId);
}
