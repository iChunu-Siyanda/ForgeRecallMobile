import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/search/domain/usecases/search_topic_use_case.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_event.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  final SearchTopicsUseCase searchTopic;

  SearchBloc({
    required this.searchTopic
  }) : super(SearchInitial()){
    on<SearchTopics>(_onSearchTopic);
  }

  Future<void> _onSearchTopic(
    SearchTopics event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    await emit.onEach(
      searchTopic(event.query),
      onData: (topics) => SearchLoaded(topics),
      onError: (e, stackTrace) {
        debugPrint("Search Error: $e");
        debugPrint("Search StackTrace: $stackTrace");
        emit(SearchError(e.toString()),);
      }
    );
  }
}
