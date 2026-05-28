abstract class TopicState {
  const TopicState();
}

class TopicInitial extends TopicState {
  const TopicInitial();
}

class TopicLoading extends TopicState{
  const TopicLoading();
}

class TopicLoaded extends TopicState {
  final List<String> topics;

  const TopicLoaded(this.topics);
}

class TopicError extends TopicState {
  final String message;

  const TopicError(this.message);
}