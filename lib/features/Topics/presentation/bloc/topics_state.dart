import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

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
  final List<TopicEntity> topics;

  const TopicLoaded(this.topics);
}

class TopicError extends TopicState {
  final String message;

  const TopicError(this.message);
}
