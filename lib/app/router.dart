import 'package:forge_recall/features/analytics/presentation/pages/analytics.dart';
import 'package:forge_recall/features/auth/presentation/navigation/auth_firebase.dart';
import 'package:forge_recall/features/profile/presentation/pages/profile.dart';
import 'package:forge_recall/features/projects/presentation/pages/projects.dart';
import 'package:forge_recall/features/recall/presentation/pages/recall.dart';
import 'package:forge_recall/features/splash/presentation/pages/splash.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/features/dashboard/presentation/pages/dashboard.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',

    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigation(child: child);
        },

        routes: [
          GoRoute(path: '/', builder: (context, state) => const Splash()),

          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const Dashboard(),
          ),

          GoRoute(
            path: '/auth',
            builder: (context, state) => const AuthFirebase(),
          ),

          GoRoute(
            path: '/projects',
            builder: (context, state) => const Projects(),
          ),

          GoRoute(path: '/recall', builder: (context, state) => const Recall()),

          GoRoute(
            path: '/analytics',
            builder: (context, state) => const Analytics(),
          ),

          GoRoute(
            path: '/profile',
            builder: (context, state) => const Profile(),
          ),
        ],
      ),
    ],
  );
}
