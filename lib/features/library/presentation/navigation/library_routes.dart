import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/shared/registrations/register_topic_module.dart';
import 'package:forge_recall/features/library/domain/entites/library_topic_params.dart';
import 'package:forge_recall/features/library/presentation/bloc/library_bloc.dart';
import 'package:forge_recall/features/library/presentation/bloc/library_event.dart';
import 'package:forge_recall/features/library/presentation/pages/library_topic_page.dart';
import 'package:go_router/go_router.dart';

class LibraryRoutes {
  static final routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.libraryTopic,
      builder: (context,state){
        final libraryTopic = state.extra as LibraryTopicParams;
        return BlocProvider(
          create: (_) => getIt<LibraryBloc>()..add(LoadLibraryTopics(libraryTopic.filter),),
          child: LibraryTopicsPage(title: libraryTopic.title, filter: libraryTopic.filter,)
          );
      },
    ),
  ];
}
