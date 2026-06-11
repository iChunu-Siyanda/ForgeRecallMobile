import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.id,
    required super.question,
    required super.solution,
  });

  factory QuestionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return QuestionModel(
      id: json['id'] as String,
      question: json['question'] as String,
      solution: json['solution'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'solution': solution,
    };
  }

  factory QuestionModel.fromEntity(
    QuestionEntity entity,
  ) {
    return QuestionModel(
      id: entity.id,
      question: entity.question,
      solution: entity.solution,
    );
  }
}