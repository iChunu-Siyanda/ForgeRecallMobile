import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class GetTopicsUseCase {
  final TopicRepository repository;
  GetTopicsUseCase(this.repository);

  Stream<List<TopicEntity>> call(String projectId) {
    return repository.getTopics(projectId);
  }
}
