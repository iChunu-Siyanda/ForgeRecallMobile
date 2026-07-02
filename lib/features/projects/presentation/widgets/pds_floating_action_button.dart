import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/projects/presentation/pages/project_detail_screen.dart';
import 'package:forge_recall/features/topics/presentation/widgets/add_topic.dart';

class PdsFloatingActionBtn extends StatelessWidget {
  const PdsFloatingActionBtn({
    super.key,
    required this.widget,
  });

  final ProjectDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: AppColours.geminiGradient,
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () => addTopic(context, widget.projectId),
          backgroundColor: Colors.transparent,
          elevation: 2,
          highlightElevation: 4,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: AppColours.surface, // Clean white icon against the gradient
          ),
        ),
      );
    }
}

