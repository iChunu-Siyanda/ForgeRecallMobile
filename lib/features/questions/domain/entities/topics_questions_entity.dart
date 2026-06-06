import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

class TopicQuestionsEntity {
  final String questionsId;
  final String projectId;
  final String topicId;

  final List<QuestionEntity> questions;

  final DateTime nextReviewDate;
  final double recallStrength;
  final DateTime createdAt;

  const TopicQuestionsEntity({
    required this.questionsId,
    required this.projectId,
    required this.topicId,
    required this.questions,
    required this.nextReviewDate,
    required this.recallStrength,
    required this.createdAt,
  });
}

// Firestore: JSON
// {
//   "questionsId": "topic_1",
//   "projectId": "math",
//   "topicId": "calculus",
//   "recallStrength": 0.72,
//   "nextReviewDate": "...",
//   "questions": [
//     {
//       "id": "q1",
//       "question": "What is a derivative?",
//       "solution": "Rate of change."
//     },
//     {
//       "id": "q2",
//       "question": "Derivative of x²?",
//       "solution": "2x"
//     }
//   ]
// }
