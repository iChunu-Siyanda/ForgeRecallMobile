class ProgressParams {
  final double dailyProgress;
  final int minutesStudiedToday;
  final int questionsAnsweredToday;
  final int topicsCompletedToday;

  ProgressParams({
    required this.dailyProgress, 
    required this.minutesStudiedToday, 
    required this.questionsAnsweredToday, 
    required this.topicsCompletedToday,
  });

  final totalPlanned = 10;  
  // Safely structure precision values mapped cleanly between 0.0 and 1.0
  double get percentCompleteFraction => (topicsCompletedToday / totalPlanned).clamp(0.0, 1.0);
  String get percentCompleteDisplay => (percentCompleteFraction * 100).toStringAsFixed(0);
}
