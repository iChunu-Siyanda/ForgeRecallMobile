import 'package:forge_recall/features/topics/domain/entities/update_topic_param.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class UpdateTopicUseCase {
  final TopicRepository repository;

  UpdateTopicUseCase(this.repository);

  Future<void> call(
    UpdateTopicParams params,
  ) async {
    final existingTopic = await repository.fetchTopicById(
      params.topicId, params.projectId,
    );

    final updatedTopic = existingTopic.copyWith(
      title: params.title,
      content: params.material,
    );

    await repository.updateTopics(
      updatedTopic,
    );
  }
}
