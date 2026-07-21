import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_state.dart';
import 'package:forge_recall/features/recall/presentation/pages/recall_session_page.dart';
import 'package:forge_recall/features/recall/presentation/pages/session_complete_page.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:go_router/go_router.dart';

class RecallRoutes {
  static final routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.recallSession,
      builder: (context, state) {
        final topic = state.extra as TopicEntity;
        //debugPrint('TOPIC: ${topic.title}');
        return RecallSessionPage(topic: topic,);
      },
    ),

    GoRoute(
      path: AppRoutes.sessionComplete,
      builder: (context, state) {
        final result = state.extra as RecallLabCompleted;

        return SessionCompletePage(
          totalQuestions: result.totalQuestions,
          easyCount: result.easyCount,
          partialCount: result.partialCount,
          forgotCount: result.forgotCount,
        );
      },
    ),
  ];
}
