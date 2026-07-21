import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/shared/registrations/register_recall_module.dart';
import 'package:forge_recall/features/projects/presentation/navigation/projects_routes.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/navigation/questions_routes.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_bloc.dart';
import 'package:forge_recall/features/recall/presentation/navigation/recall_routes.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:forge_recall/features/topics/presentation/navigation/topic_routes.dart';
import 'package:go_router/go_router.dart';

class ProjectStudyShell{
  const ProjectStudyShell._();

  static RouteBase studyShell = ShellRoute(
    builder: (context, state, child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<TopicBloc>(),),
          BlocProvider(create: (_) => getIt<QuestionsBloc>(),),
          BlocProvider(create: (_) => getIt<RecallLabBloc>(),),
        ], 
        child: child,
      );
    },
    routes: [
      ...ProjectsRoutes.routes,

      ...TopicRoutes.routes,

      ...QuestionsRoutes.routes,

      ...RecallRoutes.routes,
    ],
  );
}
