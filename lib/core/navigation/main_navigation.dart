import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:go_router/go_router.dart';

class MainNavigation extends StatefulWidget {
  final Widget child;

  const MainNavigation({
    super.key,
    required this.child,
  });

  static void openDrawer(BuildContext context) {
    context.findAncestorStateOfType<_MainNavigationState>()?.openDrawer();
  }

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String _currentRoute(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }

  void _navigate(BuildContext context, String route) {
    Navigator.pop(context); // Soft-dismiss drawer canvas

    if (_currentRoute(context) != route) {
      context.go(route);
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = _currentRoute(context);
    
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColours.background,
      drawer: Drawer(
        backgroundColor: AppColours.surface,
        surfaceTintColor: Colors.transparent, // Blocks Material 3 tint overlay
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- PREMIUM DRAWER HEADER ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [AppColours.electricBlue, Color(0xFF6366F1)], // Premium indigo gradient shift
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.bolt_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Text(
                          'ForgeRecall',
                          style: TextStyle(
                            color: AppColours.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- ACTION BUTTON HEADER PLACEMENT ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                  child: Material(
                    color: AppColours.electricBlue,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => _navigate(context, '/create-project'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'New Project',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  height: 1,
                  color: AppColours.glassBorder,
                ),

                // --- NAVIGATION ITEMS MATRIX ---
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _DrawerItem(
                        icon: Icons.search_rounded,
                        label: 'Search Workspace',
                        selected: currentRoute == '/search',
                        onTap: () => _navigate(context, '/search'),
                      ),
                      _DrawerItem(
                        icon: Icons.local_fire_department_rounded,
                        label: 'Today Focus',
                        selected: currentRoute == '/today',
                        onTap: () => _navigate(context, '/today'),
                      ),
                      _DrawerItem(
                        icon: Icons.library_books_rounded,
                        label: 'Knowledge Library',
                        selected: currentRoute == '/library',
                        onTap: () => _navigate(context, '/library'),
                      ),
                      _DrawerItem(
                        icon: Icons.folder_open_rounded,
                        label: 'Projects Index',
                        selected: currentRoute == '/projects',
                        onTap: () => _navigate(context, '/projects'),
                      ),
                      _DrawerItem(
                        icon: Icons.analytics_rounded,
                        label: 'Analytics Dashboard',
                        selected: currentRoute == '/analytics',
                        onTap: () => _navigate(context, '/analytics'),
                      ),
                    ],
                  ),
                ),

                // --- STICKY DRAWER FOOTER PROFILE PANEL ---
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 1,
                  color: AppColours.glassBorder,
                ),
                const SizedBox(height: 8),
                _DrawerItem(
                  icon: Icons.person_rounded,
                  label: 'User Profile',
                  selected: currentRoute == '/profile',
                  onTap: () => _navigate(context, '/profile'),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
      body: widget.child,
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selected ? AppColours.electricBlue.withValues(alpha:0.08) : Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            highlightColor: AppColours.electricBlue.withValues(alpha:0.04),
            splashColor: AppColours.electricBlue.withValues(alpha:0.04),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 22,
                    color: selected ? AppColours.electricBlue : AppColours.textSecondary,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        color: selected ? AppColours.electricBlue : AppColours.textPrimary,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
