import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/domain/usecases/save_questions_use_case.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_state.dart';

class QuestionsGenerationBloc extends Bloc<QuestionsGenerationEvent, QuestionsGenerationState> {
    final SaveQuestionsUseCase saveQuestionsUseCase;

  QuestionsGenerationBloc(this.saveQuestionsUseCase) : super(QuestionsInitial()) {
    on<GenerateQuestionsEvent>(_onGenerateQuestions,); 
    on<AddQuestionEvent>( _onAddQuestion,);
    on<DeleteQuestionEvent>(_onDeleteQuestion,);
    on<UpdateQuestionEvent>(_onUpdateQuestion,);
    on<SaveQuestionsEvent>(_onSaveQuestions,);
  }

  Future<void> _onGenerateQuestions(
    GenerateQuestionsEvent event,
    Emitter<QuestionsGenerationState> emit,
  ) async {
    emit(QuestionsLoading());

    await Future.delayed(
      const Duration(seconds: 1),
    );

    final generatedQuestions = [
      QuestionEntity(
        id: '1',
        question: 'What is cellular respiration?',
        solution: 'The process by which cells convert glucose into ATP.',
      ),
      QuestionEntity(
        id: '2',
        question:'Where does glycolysis occur?',
        solution: 'In the cytoplasm.',
      ),
    ];

    emit(QuestionsLoaded(generatedQuestions,),);
  }

  void _onAddQuestion(
    AddQuestionEvent event,
    Emitter<QuestionsGenerationState> emit,
  ) {
    if (state is! QuestionsLoaded) return;

    final current = (state as QuestionsLoaded).questions;

    emit(QuestionsLoaded([...current, event.question],),);
  }

  void _onDeleteQuestion(
    DeleteQuestionEvent event,
    Emitter<QuestionsGenerationState> emit,
  ) {
    if (state is! QuestionsLoaded) return;
    final current = (state as QuestionsLoaded).questions;

    emit(QuestionsLoaded(current.where((q) => q.id != event.questionId,).toList(),),
    );
  }

  void _onUpdateQuestion(
    UpdateQuestionEvent event,
    Emitter<QuestionsGenerationState> emit,
  ) {
    if (state is! QuestionsLoaded) return;

    final current = (state as QuestionsLoaded).questions;

    final updated = current.map((q) => q.id == event.question.id ? event.question: q,).toList();

    emit(QuestionsLoaded(updated),);
  }

 Future<void> _onSaveQuestions(
    SaveQuestionsEvent event,
    Emitter<QuestionsGenerationState> emit,
  ) async {
    if (state is! QuestionsLoaded) {return;}

    final questions = (state as QuestionsLoaded).questions;

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
      emit(QuestionsError(e.toString(),),);
    }
  }
}