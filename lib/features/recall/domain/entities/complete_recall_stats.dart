import 'package:flutter/services.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

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

  double get mastery => totalQuestions == 0 ? 0  : (easy + partial * 0.5) / totalQuestions;
  int get accuracy => (mastery * 100).round();

  String get performance => switch (accuracy) {
    >= 90 => 'Mastery',
    >= 75 => 'Strong Recall',
    >= 60 => 'Developing',
    _ => 'Needs Reinforcement',
  };

  Color get performanceColor => switch (accuracy) {
    >= 90 => AppColours.emerald,
    >= 75 => AppColours.electricBlue,
    >= 60 => AppColours.amber,
    _ => AppColours.crimson,
  };
}
