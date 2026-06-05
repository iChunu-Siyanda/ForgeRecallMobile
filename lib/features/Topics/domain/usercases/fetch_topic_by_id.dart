import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class FetchTopicByIdUseCase {
  final TopicRepository repository;
  FetchTopicByIdUseCase(this.repository);

  Future<void> call(String topicId, String projectId) {
    return repository.fetchTopicById(topicId, projectId);
  }
}