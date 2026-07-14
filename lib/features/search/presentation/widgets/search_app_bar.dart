import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColours.background,
      elevation: 0,
      leading: IconButton(
        onPressed: () => MainNavigation.openDrawer(context),
        icon: const Icon(
          Icons.menu,
          color: AppColours.textPrimary,
        ),
      ),
      title: const Text(
        'Search',
        style: TextStyle(
          color: AppColours.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
      ),
      centerTitle: false,
    );
  }
}