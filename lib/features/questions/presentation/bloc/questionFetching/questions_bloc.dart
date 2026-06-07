import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/usecases/get_topics_questions_user_case.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent,QuestionsState>{
  final GetTopicsQuestionsUserCase  getTopicQuestions;

  QuestionsBloc(
    this.getTopicQuestions
  ) : super(QuestionsInitialState()){
    on<QuestionsLoadedEvent>(_onQuestionsLoaded);
  }

  Future<void> _onQuestionsLoaded(
    QuestionsLoadedEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    emit(QuestionsLoadingState());

    try{
      final questions = await getTopicQuestions(event.questionsId, event.topicId, event.projectId);
      emit(QuestionsLoadedState(questions));
    } catch(e){
      emit(QuestionsErrorState('QuetionsLoaded QuestionsBloc Error ${e.toString()}'));
    }
  }
}