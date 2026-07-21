import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_bloc.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/presentation/pages/topic_knowledge_page.dart';
import 'package:go_router/go_router.dart';

class TopicRoutes {
  static final routes = <RouteBase>[
    //2.
    GoRoute(
      path: AppRoutes.topicKnowledge,
      builder: (context, state) {
        final topic = state.extra as TopicEntity;

        return BlocProvider(
          create: (_) => QuestionsGenerationBloc(),
          child: TopicKnowledgePage(topic: topic),
        );
      }
    ),
  ];
}
