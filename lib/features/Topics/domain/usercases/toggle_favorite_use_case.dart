import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class ToggleFavoriteUseCase {
  final TopicRepository repository;
  ToggleFavoriteUseCase(this.repository);

  Future<void> call(
    String projectId,
    String topicId,
    bool isFavorite,
  ) {
    return repository.toggleFavorite(projectId, topicId, isFavorite);
  }
}
