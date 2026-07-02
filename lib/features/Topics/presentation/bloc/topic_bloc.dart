//“convert knowledge into recallabke knowledge
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/topics/domain/usercases/create_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/delete_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/get_topics.dart';
import 'package:forge_recall/features/topics/domain/usercases/update_topic.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_event.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topics_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState>{
  final CreateTopicUseCase createTopic;
  final UpdateTopicUseCase updateTopic;
  final GetTopicsUseCase getTopics;
  final DeleteTopicUseCase deleteTopic;

  TopicBloc.name({
    required this.createTopic,
    required this.updateTopic,
    required this.getTopics,
    required this.deleteTopic,
  }) : super(TopicInitial()) {
    on<LoadTopics>(_onLoadTopics);
    on<CreateTopic>(_onCreateTopic);
    on<UpdateTopic>(_onUpdateTopic);
    on<DeleteTopic>(_onDeleteTopic);
  } 

  Future<void> _onLoadTopics(
    LoadTopics event,
    Emitter<TopicState> emit
  ) async {
    emit(TopicLoading());

    await emit.forEach(
      getTopics(event.projectId), 
      onData: (topics) => TopicLoaded(topics),
      onError: (error, stackTrace) {
        debugPrint('TopicBloc getTopics FIREBASE ERROR: $error'); 
        return TopicError(error.toString()); 
      },
    ); 
  }

  Future<void> _onCreateTopic(
    CreateTopic event,
    Emitter<TopicState> emit,
  ) async {
    emit(TopicLoading());

    try{
      await createTopic(event.topicParams);
    } catch(e){
      emit(TopicError('createTopic ${e.toString()}'));
    }
  }

  Future<void> _onUpdateTopic(
    UpdateTopic event, 
    Emitter<TopicState> emit,
  ) async {
    emit(TopicLoading());

    try{
      await updateTopic(event.updatedTopic);
    } catch(e) {
      emit(TopicError('TopicBloc updateTopic ${e.toString()}'));
    }
  }

  Future<void> _onDeleteTopic(
    DeleteTopic event,
    Emitter<TopicState> emit,
  ) async {
    try {
      await deleteTopic(event.topicId, event.projectId);
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }
}
