import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/shared/registrations/register_projects_module.dart';
import 'package:forge_recall/features/questions/domain/entities/question_preview_params.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/question_initial_bloc.dart/questions_prev_bloc.dart';
import 'package:forge_recall/features/questions/presentation/pages/notes_input_page.dart';
import 'package:forge_recall/features/questions/presentation/pages/questions_preview_page.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:go_router/go_router.dart';

class QuestionsRoutes {
  static final routes = <RouteBase>[
    //3.
    GoRoute(
      path: AppRoutes.notesInput,
      builder: (context, state) {
        final topic = state.extra as TopicEntity;

        return NotesInputPage(
          topic: topic,
        );
      },
    ),

    //4.
    GoRoute(
      path: AppRoutes.previewQuestions,
      builder: (context, state) {
        final args = state.extra as QuestionPreviewParams;

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<QuestionsGenerationBloc>(),),
            BlocProvider(create: (_) => getIt<QuestionsPrevBloc>(),),
          ],
          child: QuestionsPreviewPage(
              topic: args.topic,
              note: args.note,
            ),
        );
      },
    ),
  ];
}
