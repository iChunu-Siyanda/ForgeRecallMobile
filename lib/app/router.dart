import 'package:forge_recall/features/analytics/presentation/pages/analytics.dart';
import 'package:forge_recall/features/auth/presentation/navigation/auth_firebase.dart';
import 'package:forge_recall/features/auth/presentation/page/forgot_password_page.dart';
import 'package:forge_recall/features/auth/presentation/page/login_page.dart';
import 'package:forge_recall/features/auth/presentation/page/register_page.dart';
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
      GoRoute(path: '/', builder: (context, state) => const Splash()),

      GoRoute(path: '/auth', builder: (context, state) => const AuthFirebase()),

      GoRoute(
        path: '/login_page',
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/register_page',
        builder: (context,state) => const RegisterPage(),
      ),

      GoRoute(
        path: 'forgot_password_page',
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return MainNavigation(child: child);
        },

        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const Dashboard(),
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
