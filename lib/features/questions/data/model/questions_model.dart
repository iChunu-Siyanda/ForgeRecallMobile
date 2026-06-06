import 'package:forge_recall/features/questions/domain/entities/topics_questions_entity.dart';

class QuestionsModel extends TopicQuestionsEntity{
  const QuestionsModel({
    required super.questionsId,
    required super.topicId,
    required super.projectId,
    required super.questions,
    required super.recallStrength,
    required super.nextReviewDate,
    required super.createdAt,
  });

  factory QuestionsModel.fromJson(Map<String,dynamic> json) {
    return QuestionsModel(
      questionsId: json['questionsId'], 
      topicId: json['topicId'], 
      projectId: json['projectId'], 
      questions: json['questions'], 
      recallStrength: json['recallStrength'], 
      nextReviewDate: json['nextReviewDate'], 
      createdAt: json['createdAt'] != null
        ? json['createdAt'].toDate(): DateTime.now(),
    );
  }

  factory QuestionsModel.fromEntity(TopicQuestionsEntity entity){
    return QuestionsModel(
      questionsId: entity.questionsId, 
      topicId: entity.topicId, 
      projectId: entity.projectId, 
      questions: entity.questions, 
      recallStrength: entity.recallStrength, 
      nextReviewDate: entity.nextReviewDate, 
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionsId': questionsId,
      'topicId': topicId,
      'projectId': projectId,
      'questions': questions,
      'recallStrength': recallStrength,
      'nextReviewDate': nextReviewDate,
      'creayedAt': createdAt,
    };
  }
}