import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return child!;
      },
    );
  }
}
