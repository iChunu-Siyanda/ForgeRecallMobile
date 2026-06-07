import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_state.dart';

class QuestionsGenerationBloc
    extends Bloc<QuestionsGenerationEvent, QuestionsGenerationState> {

  QuestionsGenerationBloc() : super(QuestionsInitial()) {
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

    final updated = current
        .map(
          (q) => q.id == event.question.id
              ? event.question
              : q,
        )
        .toList();

    emit(QuestionsLoaded(updated),);
  }

  Future<void> _onSaveQuestions(
    SaveQuestionsEvent event,
    Emitter<QuestionsGenerationState> emit,
  ) async {
    if (state is! QuestionsLoaded) return;
    //emit(QuestionsSaving());

    try {
      //final questions = (state as QuestionsLoaded).questions;

      // TODO:
      // Save to Firestore

      await Future.delayed(
        const Duration(seconds: 1),
      );
      emit(QuestionsSaved());
    } catch (e) {
      emit(QuestionsError('QuestionsBloc, saveQuestions: ${e.toString()}',),);
    }
  }
}