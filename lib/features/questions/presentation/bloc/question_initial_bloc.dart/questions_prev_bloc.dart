import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/usecases/get_questions_prev_use_case.dart';
import 'package:forge_recall/features/questions/presentation/bloc/question_initial_bloc.dart/questions_prev_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/question_initial_bloc.dart/questions_prev_state.dart';

class QuestionsPrevBloc extends Bloc<QuestionsPrevEvent, QuestionsPrevState>{
  GetQuestionsPrevUseCase getPrevQuestions;

  QuestionsPrevBloc({
    required this.getPrevQuestions
  }):super(QuestionsPrevInitial()){
    on<QuestionsContentLoaded>(_onQuestionsInfoLoaded);
  }

  Future<void> _onQuestionsInfoLoaded(
    QuestionsContentLoaded event,
    Emitter<QuestionsPrevState> emit,
  ) async {
    emit(QuestionsPrevLoading());
    try{
      await getPrevQuestions(event.projectId,event.topicId);
    } catch(e,stack){
      debugPrint(e.toString());
      debugPrint(stack.toString());
      emit(QuestionsPrevError(e.toString()));
    }
  }
}
