import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/navigation/shell_routes.dart';
import 'package:forge_recall/features/auth/presentation/navigation/auth_routes.dart';
import 'package:forge_recall/features/questions/presentation/navigation/questions_routes.dart';
import 'package:forge_recall/features/recall/presentation/navigation/recall_routes.dart';
import 'package:forge_recall/features/splash/presentation/pages/splash.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/features/topics/presentation/navigation/topic_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const Splash()),
  
      ...AuthRoutes.routes,
      
      //PROJECTS
      ...TopicRoutes.routes,

      ...QuestionsRoutes.routes,

      ...RecallRoutes.routes,

      //NEXT
     
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigation(
            child: child,
          );
        },

        routes: ShellRoutes.routes,
      ),
    ],
  );
}
