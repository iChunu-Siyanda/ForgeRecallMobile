import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/recall/domain/entities/recall_rating.dart';

abstract class RecallLabEvent {
  const RecallLabEvent();
}

class StartRecallSessionEvent extends RecallLabEvent {
  final List<QuestionEntity> questions;
  final String projectId;

  StartRecallSessionEvent(
    this.questions, 
    this.projectId,
  );
}

class RevealAnswerEvent extends RecallLabEvent {}

class NextQuestionEvent extends RecallLabEvent {}

class RateRecallEvent extends RecallLabEvent{
  final RecallRating rating;

  RateRecallEvent(this.rating);
}

class CompleteRecallSessionEvent extends RecallLabEvent {}
