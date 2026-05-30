import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

abstract class GetTopics {
  final TopicRepository repository;
  GetTopics(this.repository);

  Future<Stream<List<TopicEntity>>> call(String projectId) async {
    return repository.getTopics(projectId);
  }
}