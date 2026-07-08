import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:go_router/go_router.dart';

class RecallSessionAppBar extends StatelessWidget {
  const RecallSessionAppBar({
    super.key,
    required this.topic,
  });

  final TopicEntity topic;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColours.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      shape: const Border(
        bottom: BorderSide(color: AppColours.glassBorder, width: 1.5),
      ),
      leading: IconButton(
        icon: const Icon(Icons.close_rounded, color: AppColours.textSecondary, size: 24),
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(
        topic.title,
        style: const TextStyle(
          color: AppColours.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
