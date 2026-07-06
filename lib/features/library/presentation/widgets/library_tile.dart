import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/shared/entites/topic_filter.dart';
import 'package:forge_recall/features/library/domain/entites/library_topic_params.dart';
import 'package:go_router/go_router.dart';

class LibraryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final TopicFilter filter;

  const LibraryTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle, 
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.push(AppRoutes.libraryTopic, extra: LibraryTopicParams(filter: filter,title: title));
        },
      ),
    );
  }
}
