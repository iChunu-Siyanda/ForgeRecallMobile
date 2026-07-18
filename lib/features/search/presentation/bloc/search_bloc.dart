// search_bloc.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/projects/domain/entities/project_card_entity.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/domain/usercases/get_projects.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:forge_recall/features/search/domain/usecases/search_topic_use_case.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_event.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_state.dart'; 

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTopicsUseCase searchTopic;
  final GetProjects getProjects;

  // Stream controllers to manage the incoming stream data and user input
  final _queryController = BehaviorSubject<String>.seeded('');
  StreamSubscription? _combinedSubscription;

  SearchBloc({
    required this.searchTopic,
    required this.getProjects,
  }) : super(SearchInitial()) {
    on<InitializeSearch>(_onInitializeSearch);
    on<SearchTextChanged>(_onSearchTextChanged);
  }

  /// 1. Initialize streams and combine them
  Future<void> _onInitializeSearch(
    InitializeSearch event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    // Cancel any previous subscription to avoid memory leaks
    await _combinedSubscription?.cancel();

    // Fetch the raw streams
    // We pass an empty string to load all topics initially for local search
    final Stream<List<TopicEntity>> topicsStream = searchTopic(''); 
    final Stream<List<ProjectCardEntity>> projectsStream = getProjects(event.userId);

    // Debounce query inputs to keep typing snappy and avoid redundant calculations
    final debouncedQueryStream = _queryController
        .debounceTime(const Duration(milliseconds: 250))
        .distinct();

    // Combine all three streams (Topics, Projects, and Search Query)
    _combinedSubscription = Rx.combineLatest3<List<TopicEntity>, List<ProjectCardEntity>, String, _SearchPayload>(
      topicsStream,
      projectsStream,
      debouncedQueryStream,
      (topics, projectCards, query) {
        final projects = projectCards.map((projectCard){
          return projectCard.project;
        }).toList();
        return _performFuzzySearch(topics, projects, query);
      },
    ).listen(
      (payload) {
        // Emit the freshly filtered results to the UI
        add(_EmitSearchResults(topics: payload.topics, projects: payload.projects));
      },
      onError: (error, stackTrace) {
        debugPrint("Search Stream Error: $error");
        debugPrint("Search StackTrace: $stackTrace");
        add(_EmitSearchError(error.toString()));
      },
    );

    // Register internal events to handle the stream outputs safely within Bloc
    on<_EmitSearchResults>((event, emit) {
      emit(
        SearchLoaded(
          event.topics, 
          event.projects,
        ),
      );
    });

    on<_EmitSearchError>((event, emit) {
      emit(SearchError(event.message));
    });
  }

  /// 2. Handle keystrokes
  void _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<SearchState> emit,
  ) {
    if (event.query.trim().isEmpty) {
      // If the query clears out, we can reset the state or keep showing unfiltered lists
      _queryController.add('');
      return;
    }
    _queryController.add(event.query);
  }

  /// 3. The Core Fuzzy Search Logic
  _SearchPayload _performFuzzySearch(
    List<TopicEntity> rawTopics,
    List<ProjectEntity> rawProjects,
    String query,
  ) {
    if (query.trim().isEmpty) {
      return _SearchPayload(topics: rawTopics, projects: rawProjects);
    }

    // --- Filter Topics ---
    final topicSearchStrings = rawTopics.map((t) {
      // 1. Collect only the non-null, non-empty fields in a list
      final components = <String>[];

      if (t.title.isNotEmpty) {
        components.add(t.title);
      }
      
      // Safe null check for content
      if (t.content.isNotEmpty) {
        components.add(t.content);
      }

      // Safe null check for tags list
      // if (t.tags != null && t.tags!.isNotEmpty) {
      //   components.add(t.tags!.join(' '));
      // }

      // 2. Join them with a space and convert to lowercase
      // If only 'title' exists, it safely returns just the title!
      return components.join(' ').toLowerCase();
    }).toList();

    final topicFuse = Fuzzy<String>(
      topicSearchStrings,
      options: FuzzyOptions(threshold: 0.35, shouldNormalize: true),
    );

    final topicResults = topicFuse.search(query.toLowerCase());
    final List<TopicEntity> filteredTopics = [];
    for (var res in topicResults) {
      final index = topicSearchStrings.indexOf(res.item);
      if (index != -1) filteredTopics.add(rawTopics[index]);
    }

    // --- Filter Projects ---
    final projectSearchStrings = rawProjects.map((p) {
      final components = <String>[];

      if (p.title.isNotEmpty) {
        components.add(p.title);
      }
      
      // Safe null check for content
      if (p.description.isNotEmpty) {
        components.add(p.description);
      }
      //return '${p.title} ${p.description} ${p.category?? ''}'.toLowerCase();

      return components.join(' ').toLowerCase();
    }).toList();

    final projectFuse = Fuzzy<String>(
      projectSearchStrings,
      options: FuzzyOptions(threshold: 0.35, shouldNormalize: true),
    );

    final projectResults = projectFuse.search(query.toLowerCase());
    final List<ProjectEntity> filteredProjects = [];
    for (var res in projectResults) {
      final index = projectSearchStrings.indexOf(res.item);
      if (index != -1) filteredProjects.add(rawProjects[index]);
    }

    return _SearchPayload(topics: filteredTopics, projects: filteredProjects);
  }

  @override
  Future<void> close() {
    _combinedSubscription?.cancel();
    _queryController.close();
    return super.close();
  }
}

/// Internal helper class to pass both lists through RxDart together
class _SearchPayload {
  final List<TopicEntity> topics;
  final List<ProjectEntity> projects;
  _SearchPayload({required this.topics, required this.projects});
}

/// Internal hidden events to route stream updates safely through Bloc's state machine
class _EmitSearchResults extends SearchEvent {
  final List<TopicEntity> topics;
  final List<ProjectEntity> projects;
  _EmitSearchResults({required this.topics, required this.projects});
}

class _EmitSearchError extends SearchEvent {
  final String message;
  _EmitSearchError(this.message);
}
