import 'package:forge_recall/feautures/analytics/presentation/pages/analytics.dart';
import 'package:forge_recall/feautures/profile/presentation/pages/profile.dart';
import 'package:forge_recall/feautures/projects/presentation/pages/projects.dart';
import 'package:forge_recall/feautures/recall/presentation/pages/recall.dart';
import 'package:forge_recall/shared/navigation/main_navigation.dart';
import 'package:forge_recall/feautures/dashboard/presentation/pages/dashboard.dart';
import 'package:go_router/go_router.dart';

class AppRouter {

  static final router = GoRouter(

    initialLocation: '/dashboard',

    routes: [

      ShellRoute(

        builder: (context, state, child) {
          return MainNavigation(
            child: child,
          );
        },

        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) =>
                const Dashboard(),
          ),

          GoRoute(
            path: '/projects',
            builder: (context, state) =>
                const Projects(),
          ),

          GoRoute(
            path:'/recall',
            builder: (context, state) =>
                const Recall(),
          ),

          GoRoute(
            path: '/analytics',
            builder: (context, state) =>
                const Analytics(),
          ),

          GoRoute(
            path: '/profile',
            builder: (context, state) =>
                const Profile(),
          ),
        ],
      ),
    ],
  );
}