import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/router.dart';
import 'package:forge_recall/core/shared/register_topic_module.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<ProjectBloc>(),),
          ],
          child: child!,
        );
      },
    );
  }
}
