import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/features/auth/presentation/navigation/auth_firebase.dart';
import 'package:forge_recall/features/auth/presentation/page/forgot_password_page.dart';
import 'package:forge_recall/features/auth/presentation/page/login_page.dart';
import 'package:forge_recall/features/auth/presentation/page/register_page.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static final routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthFirebase(),
    ),

    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterPage(),
    ),

    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
  ];
}
