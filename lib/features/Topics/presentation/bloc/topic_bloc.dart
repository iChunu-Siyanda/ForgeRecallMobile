//“convert knowledge into recallabke knowledge
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/topics/domain/entities/update_stats_params.dart';
import 'package:forge_recall/features/topics/domain/services/recall_stats_calculator.dart';
import 'package:forge_recall/features/topics/domain/usercases/create_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/delete_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/get_topics.dart';
import 'package:forge_recall/features/topics/domain/usercases/toggle_favorite_use_case.dart';
import 'package:forge_recall/features/topics/domain/usercases/update_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/update_topic_stats.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_event.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topics_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState>{
  final CreateTopicUseCase createTopic;
  final UpdateTopicUseCase updateTopic;
  final UpdateTopicStatsUseCase updateTopicStats;
  final GetTopicsUseCase getTopics;
  final DeleteTopicUseCase deleteTopic;
  final ToggleFavoriteUseCase toggleFavorite;
  final RecallStatsCalculator recallStatCalculator;

  TopicBloc.name({
    required this.createTopic,
    required this.updateTopic,
    required this.updateTopicStats,
    required this.getTopics,
    required this.deleteTopic,
    required this.toggleFavorite,
    required this.recallStatCalculator,
  }) : super(TopicInitial()) {
    on<LoadTopics>(_onLoadTopics);
    on<CreateTopic>(_onCreateTopic);
    on<UpdateTopic>(_onUpdateTopic);
    on<DeleteTopic>(_onDeleteTopic);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<UpdateTopicStats>(_onUpdateTopicStats);
  } 

  Future<void> _onLoadTopics(
    LoadTopics event,
    Emitter<TopicState> emit
  ) async {
    emit(TopicLoading());

    await emit.forEach(
      getTopics(event.query), 
      onData: (topics) => TopicLoaded(topics),
      onError: (error, stackTrace) {
        debugPrint('TopicBloc getTopics FIREBASE ERROR: $error'); 
        debugPrint('STACK TRACE:\n$stackTrace');
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

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<TopicState> emit,
  ) async {
    try{
      await toggleFavorite(event.topic.projectId, event.topic.id, event.topic.isFavorite);
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }

  Future<void> _onUpdateTopicStats(
    UpdateTopicStats event,
    Emitter<TopicState> emit,
  ) async {
    if (state is! TopicLoaded) return;
    
    try {
      final calculator = recallStatCalculator;
      final mastery = calculator.calculateMastery(
        previousMastery: event.topic.masteryScore,
        sessionMastery: event.result.mastery,
      );
      final difficulty = calculator.calculateDifficulty(mastery);
      final stats = UpdateStatsParams(
        topicId: event.topic.id,
        projectId: event.topic.projectId,
        masteryScore: mastery,
        cognitiveDifficulty: difficulty,
        studyCount: event.topic.studyCount + 1,
        lastStudiedAt: DateTime.now(),
      );

      // debugPrint('''
      //   Bloc Updating stats:
      //   mastery: $mastery
      //   difficulty: $difficulty
      //   studyCount: ${event.topic.studyCount + 1}
      // ''');

      //debugPrint(updateTopicStats.runtimeType.toString());
      await updateTopicStats(stats);
      debugPrint('Bloc finished');
    } catch (e,stackTrace) {
      debugPrint('UpdateStudyStatistics failed: $e');
      debugPrintStack(stackTrace: stackTrace);
      emit(
        TopicError(
          'UpdateStudyStatistics failed: $e',
        ),
      );
    }
  }
}
