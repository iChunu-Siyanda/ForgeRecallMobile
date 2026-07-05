import 'package:forge_recall/features/topics/domain/entities/create_topic_params.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';
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