import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/navigation/project_study_shell.dart';
import 'package:forge_recall/core/navigation/shell_routes.dart';
import 'package:forge_recall/features/auth/presentation/navigation/auth_routes.dart';
import 'package:forge_recall/features/library/presentation/navigation/library_routes.dart';
import 'package:forge_recall/features/splash/presentation/pages/splash.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/features/today/presentation/navigation/today_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const Splash()),
  
      ...AuthRoutes.routes,
      
      //Projects
      ProjectStudyShell.studyShell,
      
      //Library
      ...LibraryRoutes.routes,

      //Today
      ...TodayRoutes.routes,
     
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
