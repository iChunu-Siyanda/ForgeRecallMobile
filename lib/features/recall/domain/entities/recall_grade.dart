import 'dart:ui';

import 'package:forge_recall/core/theme/app_colours.dart';

enum RecallGrade {
  mastery,
  strong,
  developing,
  reinforcement;

  static RecallGrade fromAccuracy(int accuracy) {
    if (accuracy >= 90) return RecallGrade.mastery;
    if (accuracy >= 75) return RecallGrade.strong;
    if (accuracy >= 60) return RecallGrade.developing;
    return RecallGrade.reinforcement;
  }

  String get label => switch (this) {
        RecallGrade.mastery => 'Mastery',
        RecallGrade.strong => 'Strong Recall',
        RecallGrade.developing => 'Developing',
        RecallGrade.reinforcement => 'Needs Reinforcement',
      };

  Color get colour => switch (this) {
        RecallGrade.mastery => AppColours.emerald,
        RecallGrade.strong => AppColours.electricBlue,
        RecallGrade.developing => AppColours.amber,
        RecallGrade.reinforcement => AppColours.crimson,
      };
}
