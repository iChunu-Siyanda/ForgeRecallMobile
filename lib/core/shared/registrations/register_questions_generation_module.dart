import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerQuestionsGenerationModule () {
  getIt.registerFactory(
    () => QuestionsGenerationBloc(),
  );
}
