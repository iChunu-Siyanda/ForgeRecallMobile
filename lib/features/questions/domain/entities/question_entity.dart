class QuestionEntity {
  final String id;
  final String question;
  final String solution;

  const QuestionEntity({
    required this.id,
    required this.question,
    required this.solution,
  });

  QuestionEntity copyWith({
    String? id,
    String? question,
    String? solution,
  }) {
    return QuestionEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      solution: solution ?? this.solution,
    );
  }
}
