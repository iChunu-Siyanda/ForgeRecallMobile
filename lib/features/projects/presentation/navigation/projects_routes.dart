import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/shared/registrations/register_firebase_module.dart';
import 'package:forge_recall/features/projects/domain/entities/project_detail_stats.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectDetailBloc/project_detail_bloc.dart';
import 'package:forge_recall/features/projects/presentation/pages/project_detail_screen.dart';
import 'package:go_router/go_router.dart';

class ProjectsRoutes {
  const ProjectsRoutes._();

  static final routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.projectDetailRoute,
      builder: (context, state) {
        final projectId = state.pathParameters['id']!;
        final stats = state.extra as ProjectDetailStats;

        return BlocProvider(
          create: (_) => getIt<ProjectDetailBloc>(),
          child: ProjectDetailScreen(
            projectId: projectId, 
            stats: stats,
          )
        ,);
      },
    ),
  ];
}
