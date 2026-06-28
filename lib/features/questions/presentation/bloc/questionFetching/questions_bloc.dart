import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/domain/usecases/get_topics_questions_user_case.dart';
import 'package:forge_recall/features/questions/domain/usecases/save_questions_use_case.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent,QuestionsState>{
  final GetTopicsQuestionsUseCase  getQuestionsUseCase;
  final SaveQuestionsUseCase saveQuestionsUseCase;
  StreamSubscription<List<QuestionEntity>>? _questionsSubscription;

  QuestionsBloc(
    this.getQuestionsUseCase,
    this.saveQuestionsUseCase,
  ) : super(QuestionsInitialState()){
    on<QuestionsLoadedEvent>(_onQuestionsLoaded);
    on<AddQuestionEvent>( _onAddQuestion,);
    on<DeleteQuestionEvent>(_onDeleteQuestion,);
    on<UpdateQuestionEvent>(_onUpdateQuestion,);
    on<SaveQuestionsEvent>(_onSaveQuestions,);
    on<QuestionsUpdatedEvent>(_onQuestionsUpdated);
    on<QuestionsErrorEvent>(_onQuestionsError);
  }

  Future<void> _onQuestionsLoaded(
    QuestionsLoadedEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    emit(QuestionsLoadingState());
    debugPrint("Starting Firestore listener...");

    // Stop any previous listener
    await _questionsSubscription?.cancel();

    // Start listening
    _questionsSubscription = getQuestionsUseCase(
      event.projectId,
      event.topicId,
    ).listen((questions) {
        debugPrint("Firestore changed. ${questions.length} questions found.",);
        add(QuestionsUpdatedEvent(questions),);
      },

      onError: (error) {
        add(QuestionsErrorEvent(error.toString()),);
      },
    );
  }

  Future<void> _onAddQuestion(
    AddQuestionEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    // 1. Guard check: Ensure we already have a loaded list to append to
    debugPrint("ADD QUESTION EVENT RECEIVED");
    final currentQuestions = state is QuestionsLoadedState  
                            ? (state as QuestionsLoadedState).topicQuestions  
                            : <QuestionEntity>[];

    try {
      // 2. Persist the new question to Firestore.
      // Because RemoteDatasource uses a Firestore batch set by document ID, 
      // sending just the new question in a list is highly efficient.
      debugPrint("Calling saveQuestionsUseCase");
      await saveQuestionsUseCase(
        projectId: event.projectId,
        topicId: event.topicId,
        questions: [event.question], 
      );
      debugPrint("saveQuestionsUseCase completed");

      // 3. Update local UI state only after successful backend persistence
      emit(QuestionsLoadedState([...currentQuestions, event.question]));
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());

      emit(QuestionsErrorState('Failed: $e',),);
    } 
  }

  void _onDeleteQuestion(
    DeleteQuestionEvent event,
    Emitter<QuestionsState> emit,
  ) {
    if (state is! QuestionsLoadedState) return;
    final current = (state as QuestionsLoadedState).topicQuestions;

    emit(QuestionsLoadedState(current.where((q) => q.id != event.questionId,).toList(),),
    );
  }

  void _onUpdateQuestion(
    UpdateQuestionEvent event,
    Emitter<QuestionsState> emit,
  ) {
    if (state is! QuestionsLoadedState) return;
    final current = (state as QuestionsLoadedState).topicQuestions;
    final updated = current.map((q) => q.id == event.question.id ? event.question: q,).toList();

    emit(QuestionsLoadedState(updated),);
  }

 Future<void> _onSaveQuestions(
    SaveQuestionsEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    if (state is! QuestionsLoadedState) {return;}
    final questions = (state as QuestionsLoadedState).topicQuestions;

    emit(QuestionsSaving(questions,),);

    try {
      debugPrint('START SAVE');
      await saveQuestionsUseCase(
        projectId: event.projectId,
        topicId: event.topicId,
        questions: questions,
      );
      debugPrint('SAVE COMPLETE');
      emit(QuestionsSaveSuccess());
    } catch (e) {
      debugPrint('SAVE ERROR');
      debugPrint(e.toString());
      emit(QuestionsErrorState(e.toString(),),);
    }
  }

  void _onQuestionsUpdated(
    QuestionsUpdatedEvent event,
    Emitter<QuestionsState> emit,
  ) {

    emit(
      QuestionsLoadedState(event.questions),
    );

  }

  void _onQuestionsError(
    QuestionsErrorEvent event,
    Emitter<QuestionsState> emit,
  ) {

    emit(
      QuestionsErrorState(event.message),
    );

  }

  @override
  Future<void> close() async {
    debugPrint("Cancelling Firestore listener...");

    await _questionsSubscription?.cancel();
    return super.close();
  }
}
