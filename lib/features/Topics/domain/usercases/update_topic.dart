import 'package:forge_recall/features/topics/data/models/topic_model.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

abstract class UpdateTopic {
  final TopicRepository repository;
  UpdateTopic(this.repository);

  Future<void> call(TopicModel topic) async {
    return repository.updateTopics(topic);
  }
}