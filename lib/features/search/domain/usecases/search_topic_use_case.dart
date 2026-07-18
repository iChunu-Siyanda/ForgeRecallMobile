import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class SearchTopicsUseCase {
  final TopicRepository repository;
  SearchTopicsUseCase(this.repository);

  Stream<List<TopicEntity>> call(String search) {
    return repository.getTopics(
        TopicQuery(
            search: search,
        ),
    );
  }
}
