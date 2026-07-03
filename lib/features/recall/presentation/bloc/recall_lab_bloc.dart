import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/recall/domain/entities/recall_rating.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_event.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_state.dart';

class RecallLabBloc extends Bloc<RecallLabEvent,RecallLabState> {
  RecallLabBloc(): super(RecallLabInitial(),) {
    on<StartRecallSessionEvent>(_onStartSession,);
    on<RevealAnswerEvent>(_onRevealAnswer,);
    on<RateRecallEvent>(_onRateRecall,);
    on<NextQuestionEvent>(_onNextQuestion,);
  }

  void _onStartSession(
    StartRecallSessionEvent event,
    Emitter<RecallLabState> emit,
  ) {
    if (event.questions.isEmpty) {
      debugPrint('event.questions. is empty');
      return;
    }
    emit(
      RecallLabLoaded(
        questions: event.questions,
        currentIndex: 0,
        answerRevealed: false,
        forgotCount: 0,
        partialCount: 0,
        easyCount: 0,
      ),
    );
  }

  void _onRevealAnswer(
    RevealAnswerEvent event,
    Emitter<RecallLabState> emit,
  ) {
    if (state is! RecallLabLoaded) {return;}

    final current = state as RecallLabLoaded;

    emit(
      RecallLabLoaded(
        questions: current.questions,
        currentIndex:current.currentIndex,
        answerRevealed: true,
        forgotCount: current.forgotCount,
        partialCount: current.partialCount,
        easyCount: current.easyCount,
      ),
    );
  }

  void _onRateRecall(
    RateRecallEvent event,
    Emitter<RecallLabState> emit,
  ) {
    if (state is! RecallLabLoaded) { return; }

    final current = state as RecallLabLoaded;

    emit(
      RecallLabLoaded(
        questions: current.questions,
        currentIndex: current.currentIndex,
        answerRevealed: current.answerRevealed,
        forgotCount: event.rating == RecallRating.forgot
                ? current.forgotCount + 1 : current.forgotCount,
        partialCount: event.rating == RecallRating.partial
                ? current.partialCount + 1 : current.partialCount,
        easyCount: event.rating ==RecallRating.easy
                ? current.easyCount + 1 : current.easyCount,
      ),
    );
  }

  void _onNextQuestion(
    NextQuestionEvent event,
    Emitter<RecallLabState> emit,
  ) {
    if (state is! RecallLabLoaded) {return;}

    final current = state as RecallLabLoaded;

    if (current.isLastQuestion) {
      emit(
        RecallLabCompleted(
          totalQuestions: current.questions.length,
          easyCount: current.easyCount,
          partialCount: current.partialCount,
          forgotCount: current.forgotCount,
        ),
      );

      return;
    }

    emit(
      RecallLabLoaded(
        questions: current.questions,
        currentIndex: current.currentIndex + 1,
        answerRevealed: false,
        forgotCount: current.forgotCount,
        partialCount: current.partialCount,
        easyCount: current.easyCount,
      ),
    );
  }
}
