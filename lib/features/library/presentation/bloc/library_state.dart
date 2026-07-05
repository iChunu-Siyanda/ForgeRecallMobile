import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

abstract class LibraryState {
  const LibraryState();
}

class LibraryLoading extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final List<TopicEntity> topics;

  LibraryLoaded(this.topics);
}

class LibraryError extends LibraryState {
  final String message;

  LibraryError(this.message);
}
