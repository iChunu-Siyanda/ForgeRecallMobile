import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/presentation/pages/project_detail_screen.dart';
import 'package:forge_recall/features/topics/presentation/widgets/add_topic.dart';

class PdsFloatingActionBtn extends StatelessWidget {
  const PdsFloatingActionBtn({
    super.key,
    required bool showFab,
    required this.widget,
  }) : _showFab = showFab;

  final bool _showFab;
  final ProjectDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      // We use transitionBuilder to make it fade and slightly scale
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: _showFab
          ? FloatingActionButton.extended(
              key: const ValueKey('fab_active'), // Unique key
              // heroTag: null, // Ensure Hero is disabled or removed
              onPressed: () => addTopic(context, widget.projectId),
              icon: const Icon(Icons.add),
              label: const Text('Add Topic'),
            )
          : const SizedBox.shrink(key: ValueKey('fab_hidden')), // Unique key
    );
  }
}
