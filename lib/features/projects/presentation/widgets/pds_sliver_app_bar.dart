import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:go_router/go_router.dart';
// import 'package:your_app/theme/app_colours.dart'; 

class PdsSliverAppBar extends StatelessWidget {
  const PdsSliverAppBar({
    super.key,
    required this.project,
  });

  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: AppColours.background,
      elevation: 0,
      // Subtle bottom divider line matching Google/Gemini standards
      shape: const Border(
        bottom: BorderSide(
          color: AppColours.glassBorder,
          width: 1,
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColours.textPrimary, // Swapped from white to off-black
          size: 20,
        ),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/projects');
          }
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
          left: 56, // Adjusted to clear back button neatly
          bottom: 16,
        ),
        title: Text(
          project.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600, // Slightly cleaner weight for light mode
            color: AppColours.textPrimary,
            fontSize: 18,
            letterSpacing: -0.3,
          ),
        ),
        // Removed the heavy decorative background stacks for workspace clarity
        background: Container(color: AppColours.background),
      ),
    );
  }
}
