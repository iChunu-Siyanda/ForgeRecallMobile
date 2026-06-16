import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/presentation/pages/project_detail_screen.dart';
import 'package:forge_recall/features/projects/presentation/widgets/add_topic_button.dart';
import 'package:forge_recall/features/topics/presentation/widgets/add_topic.dart';

class PdsAddTopicBtn extends StatelessWidget {
  const PdsAddTopicBtn({
    super.key,
    required bool showFab,
    required this.widget,
  }) : _showFab = showFab;

  final bool _showFab;
  final ProjectDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            const SizedBox(height: 26),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  ),
                );
              },
              child: !_showFab
                  ? AddTopicButton(
                      key: const ValueKey('inline_btn_active'), // Unique key
                      onTap: () => addTopic(context, widget.projectId),
                    )
                  : const SizedBox.shrink(key: ValueKey('inline_btn_hidden')), // Unique key
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
