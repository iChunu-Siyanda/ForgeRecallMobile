import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

abstract class DeleteTopic {
  final TopicRepository repository;
  DeleteTopic(this.repository);

  Future<void> call(String topicId, String projectId) async {
    return repository.deleteTopic(topicId, projectId);
  }
}