import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/shared/registrations/register_firebase_module.dart';
import 'package:forge_recall/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:forge_recall/features/analytics/presentation/bloc/analytics_event.dart';
import 'package:forge_recall/features/analytics/presentation/pages/analytics.dart';
import 'package:forge_recall/features/library/presentation/pages/library_page.dart';
import 'package:forge_recall/features/profile/presentation/pages/profile.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_bloc.dart';
import 'package:forge_recall/features/projects/presentation/pages/projects.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_bloc.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_event.dart';
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
          child: const Projects(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.search,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<SearchBloc>()..add(InitializeSearch(userId: FirebaseAuth.instance.currentUser!.uid)),
          child: const SearchPage(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.today,
      builder: (context,state) {
        return BlocProvider(
          create: (_) => getIt<TodayBloc>()..add(LoadToday()),
          child: const TodayPage(),
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
        final userId = FirebaseAuth.instance.currentUser?.uid;

        if (userId == null) {
          // Option A: Redirect or show fallback if no user is logged in
          return const Scaffold(
            body: Center(
              child: Text('Please log in to view analytics.'),
            ),
          );
        }
        return BlocProvider(
          create: (_) => getIt<AnalyticsBloc>(param1: userId)..add(const FetchAnalyticsData()),
          child: const AnalyticsPage(),
        );
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
