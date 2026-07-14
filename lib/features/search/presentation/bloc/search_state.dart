import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

sealed class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
    final List<TopicEntity> topics;

    const SearchLoaded(this.topics);
}

class SearchEmpty extends SearchState {
  const SearchEmpty();
}

class SearchError extends SearchState {
    final String message;

    const SearchError(this.message);
}
