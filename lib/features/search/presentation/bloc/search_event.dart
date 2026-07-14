sealed class SearchEvent {
  const SearchEvent();
}

class SearchTopics extends SearchEvent {
  final String query;

  const SearchTopics(this.query);
}

class ClearSearch extends SearchEvent {
  const ClearSearch();
}
