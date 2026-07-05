import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/library/presentation/bloc/library_event.dart';
import 'package:forge_recall/features/library/presentation/bloc/library_state.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:forge_recall/features/topics/domain/usercases/get_topics.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetTopicsUseCase getTopics;

  LibraryBloc(
    this.getTopics,
  ) : super(LibraryLoading()) {
    on<LoadLibraryTopics>(_onLoadLibraryTopics,);
  }

  Future<void> _onLoadLibraryTopics(
    LoadLibraryTopics event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading());

    await emit.forEach(
      getTopics(TopicQuery(filter: event.filter,),),
      onData: (topics) {
        return LibraryLoaded(
          topics,
        );
      },
      onError: (error, _) {
        return LibraryError(
          error.toString(),
        );
      },
    );
  }
}
