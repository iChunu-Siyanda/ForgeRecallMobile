import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class QuestionPreviewParams {
  final TopicEntity topic;
  final String note;

  QuestionPreviewParams({required this.topic, required this.note});
}