import 'package:forge_recall/core/shared/entites/topic_filter.dart';

abstract class LibraryEvent {
  const LibraryEvent();
}

class LoadLibraryTopics extends LibraryEvent {
  final TopicFilter filter;

  LoadLibraryTopics(this.filter);
}
