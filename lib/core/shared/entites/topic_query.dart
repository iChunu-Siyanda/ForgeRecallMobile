import 'package:forge_recall/core/shared/entites/topic_filter.dart';

class TopicQuery {
  final String? projectId;
  final String? search;
  final TopicFilter? filter;

  const TopicQuery({
    this.projectId,
    this.search,
    this.filter,
  });
}
