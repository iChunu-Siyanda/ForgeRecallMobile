import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class GetTopicsUseCase {
  final TopicRepository repository;
  GetTopicsUseCase(this.repository);

  Stream<List<TopicEntity>> call(TopicQuery query) {
    return repository.getTopics(query);
  }
}
