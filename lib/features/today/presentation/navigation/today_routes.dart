import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/features/today/presentation/pages/today_page.dart';
import 'package:go_router/go_router.dart';

class TodayRoutes {
  static final routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.today,
      builder: (context,state) {
        return TodayPage();
      },
    ),
  ];
}
