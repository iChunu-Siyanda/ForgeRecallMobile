import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/shared/registrations/register_firebase_module.dart';
import 'package:forge_recall/features/projects/domain/entities/project_detail_stats.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectDetailBloc/project_detail_bloc.dart';
import 'package:forge_recall/features/projects/presentation/pages/project_detail_screen.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_bloc.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:forge_recall/features/topics/presentation/pages/topic_knowledge_page.dart';
import 'package:go_router/go_router.dart';

class TopicRoutes {
  static final routes = <RouteBase>[
    //1.
    GoRoute(
      path: AppRoutes.projectDetailRoute,
      builder: (context, state) {
        final projectId = state.pathParameters['id']!;
        final stats = state.extra as ProjectDetailStats;

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<TopicBloc>(),),
            BlocProvider(create: (_) => getIt<ProjectDetailBloc>(),),
          ],
          child: ProjectDetailScreen(
            projectId: projectId, 
            stats: stats,
          )
        ,);
      },
    ),

    //2.
    GoRoute(
      path: AppRoutes.topicKnowledge,
      builder: (context, state) {
        final topic = state.extra as TopicEntity;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt<QuestionsBloc>()..add(QuestionsLoadedEvent(topic.projectId,topic.id)),
            ),
            BlocProvider(
              create: (_) => QuestionsGenerationBloc()
            )
          ], 
          child: TopicKnowledgePage(topic: topic),
        );
      }
    ),
  ];
}
