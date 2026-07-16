//import 'package:flutter/foundation.dart';

//@immutable
abstract class SearchEvent {}

/// Call this when entering the SearchPage to boot up the Firestore listeners
class InitializeSearch extends SearchEvent {
  final String userId;

  InitializeSearch({required this.userId});
}

/// Call this on every keystroke change in your search text field
class SearchTextChanged extends SearchEvent {
  final String query;

  SearchTextChanged({required this.query});
}
