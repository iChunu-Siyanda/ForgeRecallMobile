class UpdateTopicParams {
  final String topicId;
  final String projectId;
  final String? title;
  final String? content;

  UpdateTopicParams({
    required this.topicId,
    required this.projectId,
    this.title,
    this.content,
  });
}