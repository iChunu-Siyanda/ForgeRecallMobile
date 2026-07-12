import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/shared/registrations/register_firebase_module.dart';
import 'package:forge_recall/features/analytics/presentation/pages/analytics.dart';
import 'package:forge_recall/features/library/presentation/pages/library_page.dart';
import 'package:forge_recall/features/profile/presentation/pages/profile.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_bloc.dart';
import 'package:forge_recall/features/projects/presentation/pages/projects.dart';
import 'package:forge_recall/features/search/presentation/pages/search_page.dart';
import 'package:forge_recall/features/today/presentation/bloc/today_bloc.dart';
import 'package:forge_recall/features/today/presentation/bloc/today_event.dart';
import 'package:forge_recall/features/today/presentation/pages/today_page.dart';
import 'package:go_router/go_router.dart';

class ShellRoutes {
  static final routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.projects,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<ProjectBloc>(),
          child: Projects(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.search,
      builder: (context, state) {
        return const SearchPage();
      },
    ),

    GoRoute(
      path: AppRoutes.today,
      builder: (context,state) {
        return BlocProvider(
          create: (_) => getIt<TodayBloc>()..add(LoadToday()),
          child: TodayPage(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.library,
      builder: (context, state) {
        return const LibraryPage();
      },
    ),

    GoRoute(
      path: AppRoutes.analytics,
      builder: (context, state) {
        return const Analytics();
      },
    ),

    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) {
        return const Profile();
      },
    ),
  ];
}
