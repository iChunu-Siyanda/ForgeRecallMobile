class RecallStatsCalculator {
  const RecallStatsCalculator();

  double calculateMastery({
    required double previousMastery,
    required double sessionMastery,
  }) {
    // Weighted average so mastery changes gradually
    return (previousMastery * 0.8) + (sessionMastery * 0.2);
  }

  double calculateDifficulty(double mastery) {
    return 1 - mastery;
  }
}
