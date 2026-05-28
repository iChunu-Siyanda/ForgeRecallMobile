abstract class TopicEvent {
  const TopicEvent();
}

class LoadTopics extends TopicEvent {
  const LoadTopics();
}

class CreateTopic extends TopicEvent {
  final String topicName;

  const CreateTopic(this.topicName);
}

class UpdateTopic extends TopicEvent {
  final String topicName;
  final String newTopicName;

  const UpdateTopic(this.topicName, this.newTopicName);
}

class DeleteTopic extends TopicEvent {
  final String topicName;

  const DeleteTopic(this.topicName);
}