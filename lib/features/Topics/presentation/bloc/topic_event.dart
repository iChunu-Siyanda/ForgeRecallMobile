import 'package:forge_recall/features/recall/domain/entities/complete_recall_stats.dart';
import 'package:forge_recall/features/topics/domain/entities/create_topic_params.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/entities/update_topic_param.dart';

abstract class TopicEvent {
  const TopicEvent();
}

class LoadTopics extends TopicEvent {
  final TopicQuery query;

  LoadTopics(this.query);
}

class CreateTopic extends TopicEvent {
  final CreateTopicParams topicParams;

  const CreateTopic(this.topicParams);
}

class UpdateTopic extends TopicEvent {
  final UpdateTopicParams updatedTopic;

  const UpdateTopic(this.updatedTopic,);
}

class DeleteTopic extends TopicEvent {
  final String topicId;
  final String projectId;

  const DeleteTopic(this.topicId, this.projectId);
}

class ToggleFavoriteEvent extends TopicEvent {
  final TopicEntity topic;

  ToggleFavoriteEvent(this.topic);
}

class RefreshTopics extends TopicEvent {
  final TopicQuery query;

  RefreshTopics(this.query);
}

class UpdateTopicStats extends TopicEvent {
  final TopicEntity topic;
  final CompleteRecallStats result;

  const UpdateTopicStats({
    required this.topic,
    required this.result,
  });
}
