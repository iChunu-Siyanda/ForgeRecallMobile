class RecallStatsCalculator {
   const RecallStatsCalculator({
    this.learningRate = 0.2,
  });

  final double learningRate;

  double calculateMastery({
    required double previousMastery,
    required double sessionMastery,
  }) {
    return previousMastery + (sessionMastery - previousMastery) * learningRate;
  }

  double reviewPriority(double mastery) => 1 - mastery;
}
