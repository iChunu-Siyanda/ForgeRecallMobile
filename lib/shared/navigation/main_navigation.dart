import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forge_recall/shared/widgets/nav_item.dart';
import 'package:forge_recall/theme/app_colours.dart';
import 'package:go_router/go_router.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    switch (location) {
      case '/dashboard':
        return 0;

      case '/projects':
        return 1;

      case '/recall':
        return 2;

      case '/analytics':
        return 3;

      case '/profile':
        return 4;

      default:
        return 0;
    }
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;

      case 1:
        context.go('/projects');
        break;

      case 2:
        context.go('/recall');
        break;

      case 3:
        context.go('/analytics');
        break;

      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getIndex(context);

    return Scaffold(
      extendBody: true,

      body: child,

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(18),

        height: 82,

        decoration: BoxDecoration(
          color: AppColours.graphite.withValues(alpha: 0.92),

          borderRadius: BorderRadius.circular(28),

          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.45),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              icon: Icons.grid_view_rounded,
              label: "Forge",
              isSelected: currentIndex == 0,
              onTap: () => _onTap(context, 0),
            ),

            NavItem(
              icon: Icons.folder_open_rounded,
              label: "Projects",
              isSelected: currentIndex == 1,
              onTap: () => _onTap(context, 1),
            ),

            // RECALL BUTTON
            GestureDetector(
              onTap: () => _onTap(context, 2),

              child:
                  Container(
                        width: 76,
                        height: 76,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,

                            colors: [
                              AppColours.electricBlue,
                              AppColours.emberOrange,
                            ],
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: AppColours.electricBlue.withValues(
                                alpha: 0.45,
                              ),
                              blurRadius: 28,
                              spreadRadius: 2,
                            ),

                            BoxShadow(
                              color: AppColours.emberOrange.withValues(
                                alpha: 0.25,
                              ),
                              blurRadius: 40,
                              spreadRadius: 4,
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.bolt_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      )
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.06, 1.06),
                        duration: 1800.ms,
                        curve: Curves.easeInOut,
                      )
                      .shimmer(duration: 2800.ms, color: Colors.white24),
            ),

            NavItem(
              icon: Icons.analytics_rounded,
              label: "Analytics",
              isSelected: currentIndex == 3,
              onTap: () => _onTap(context, 3),
            ),

            NavItem(
              icon: Icons.person_rounded,
              label: "Profile",
              isSelected: currentIndex == 4,
              onTap: () => _onTap(context, 4),
            ),
          ],
        ),
      ),
    );
  }
}
