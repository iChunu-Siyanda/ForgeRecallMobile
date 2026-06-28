import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_state.dart';

class QuestionsGenerationBloc extends Bloc<QuestionsGenerationEvent, QuestionsGenerationState> {
  QuestionsGenerationBloc() : super(QuestionsInitial()) {
    on<GenerateQuestionsEvent>(_onGenerateQuestions,); 
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
}
