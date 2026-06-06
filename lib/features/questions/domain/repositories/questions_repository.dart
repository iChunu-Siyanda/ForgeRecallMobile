import 'package:forge_recall/features/questions/domain/entities/topics_questions_entity.dart';

abstract class QuestionsRepository {
    //get questions
  Future<TopicQuestionsEntity> getTopicQuestions(String questionsId, String topicId, String projectId);
}