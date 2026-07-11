import 'package:forge_recall/features/questions/domain/usecases/get_questions_prev_use_case.dart';
import 'package:forge_recall/features/questions/presentation/bloc/question_initial_bloc.dart/questions_prev_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerQuestionsPrevModule() {
  getIt.registerLazySingleton(
    () => GetQuestionsPrevUseCase(getIt(),),
  );

  getIt.registerFactory(
    () => QuestionsPrevBloc(
      getPrevQuestions: getIt(),
    ),
  );
}
