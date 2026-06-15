import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:go_router/go_router.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({
    super.key,
    required this.child,
  });

  String _currentRoute(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }

  void _navigate(
    BuildContext context,
    String route,
  ) {
    Navigator.pop(context); // Close drawer

    if (_currentRoute(context) != route) {
      context.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = _currentRoute(context);

    return Scaffold(
      backgroundColor: AppColours.obsidian,

      drawer: Drawer(
        backgroundColor: AppColours.graphite,

        child: SafeArea(
          child: Column(
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [

                    Container(
                      width: 42,
                      height: 42,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColours.electricBlue,
                      ),

                      child: const Icon(
                        Icons.bolt_rounded,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Text(
                        'ForgeRecall',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(),

              _DrawerItem(
                icon: Icons.add_circle_outline_rounded,
                label: 'New Project',
                selected: false,
                onTap: () => _navigate(context, '/create-project'),
              ),

              _DrawerItem(
                icon: Icons.search_rounded,
                label: 'Search',
                selected: currentRoute == '/search',
                onTap: () => _navigate(context, '/search'),
              ),

              _DrawerItem(
                icon: Icons.local_fire_department_rounded,
                label: 'Today',
                selected: currentRoute == '/today',
                onTap: () => _navigate(context, '/today'),
              ),

              _DrawerItem(
                icon: Icons.library_books_rounded,
                label: 'Library',
                selected: currentRoute == '/library',
                onTap: () => _navigate(context, '/library'),
              ),

              _DrawerItem(
                icon: Icons.folder_open_rounded,
                label: 'Projects',
                selected: currentRoute == '/projects',
                onTap: () => _navigate(context, '/projects'),
              ),

              _DrawerItem(
                icon: Icons.analytics_rounded,
                label: 'Analytics',
                selected: currentRoute == '/analytics',
                onTap: () => _navigate(context, '/analytics'),
              ),

              const Spacer(),

              const Divider(),

              _DrawerItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                selected: currentRoute == '/profile',
                onTap: () => _navigate(context, '/profile'),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),

      body: child,
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
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? AppColours.electricBlue : null,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight:
              selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}


// appBar: AppBar(
//   leading: Builder(
//     builder: (context) => IconButton(
//       icon: const Icon(Icons.menu),
//       onPressed: () {
//         Scaffold.of(context).openDrawer();
//       },
//     ),
//   ),
// ),
