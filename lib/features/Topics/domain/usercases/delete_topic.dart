import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class DeleteTopicUseCase {
  final TopicRepository repository;
  DeleteTopicUseCase(this.repository);

  Future<void> call(String topicId, String projectId) async {
    return repository.deleteTopic(topicId, projectId);
  }
}