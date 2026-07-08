import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class RecallQuestionsEmpty extends StatelessWidget {
  const RecallQuestionsEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No questions found.',
        style: TextStyle(color: AppColours.textMuted, fontSize: 15),
      ),
    );
  }
}
