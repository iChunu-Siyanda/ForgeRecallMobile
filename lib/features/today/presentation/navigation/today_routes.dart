import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/shared/registrations/register_today_module.dart';
import 'package:forge_recall/features/today/presentation/bloc/today_bloc.dart';
import 'package:forge_recall/features/today/presentation/bloc/today_event.dart';
import 'package:forge_recall/features/today/presentation/pages/today_page.dart';
import 'package:go_router/go_router.dart';

class TodayRoutes {
  static final routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.today,
      builder: (context,state) {
        return BlocProvider(
          create: (_) => getIt<TodayBloc>()..add(LoadToday()),
          child: TodayPage(),
        );
      },
    ),
  ];
}
