import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:go_router/go_router.dart';

class PdsSliverAppBar extends StatelessWidget {
  const PdsSliverAppBar({
    super.key,
    required this.project,
  });

  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
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
          left: 24,
          bottom: 18,
        ),
        title: Text(
          project.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF111827),
                    Color(0xFF070B14),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -50,
              right: -40,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple.withValues(
                    alpha: 0.18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
