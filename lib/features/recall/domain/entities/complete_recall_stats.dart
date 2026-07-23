import 'package:forge_recall/features/recall/domain/entities/recall_grade.dart';

class CompleteRecallStats {
  final int totalQuestions;
  final int easy;
  final int partial;
  final int forgot;

  const CompleteRecallStats({
    required this.totalQuestions, 
    required this.easy, 
    required this.partial, 
    required this.forgot
  });

  double get recallScore => totalQuestions == 0 ? 0  : (easy + partial * 0.5) / totalQuestions;
  int get accuracy => (recallScore * 100).round();
  double get easyRate => easy / totalQuestions;
  double get partialRate => partial / totalQuestions;
  double get forgotRate => forgot / totalQuestions;
  bool get passed => accuracy >= 70;

  RecallGrade get grade => RecallGrade.fromAccuracy(accuracy);
}
