import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/usecases/get_topics_questions_user_case.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent,QuestionsState>{
  final GetTopicsQuestionsUseCase  getQuestionsUseCase;

  QuestionsBloc(
    this.getQuestionsUseCase
  ) : super(QuestionsInitialState()){
    on<QuestionsLoadedEvent>(_onQuestionsLoaded);
  }

  Future<void> _onQuestionsLoaded(
    QuestionsLoadedEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    emit(QuestionsLoadingState());

    try {
      debugPrint('LOADING QUESTIONS');

      final questions =  await getQuestionsUseCase(event.projectId,event.topicId,);

      debugPrint('QUESTIONS FOUND: ${questions.length}',);

      emit(QuestionsLoadedState(questions,),);
    } catch (e) {
      debugPrint('LOAD ERROR');
      debugPrint(e.toString());

      emit(QuestionsErrorState(e.toString(),),);
    }
  }
}