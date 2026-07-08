import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_state.dart';

class RecallQuestionsError extends StatelessWidget {
  const RecallQuestionsError({
    super.key,
    required this.questionsState,
  });

  final QuestionsErrorState questionsState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, color: AppColours.crimson, size: 44),
            const SizedBox(height: 12),
            Text(
              questionsState.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColours.crimson,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

