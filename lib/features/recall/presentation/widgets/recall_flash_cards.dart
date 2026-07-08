import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_state.dart';

class RecallFlashCards extends StatelessWidget {
  const RecallFlashCards({
    super.key,
    required this.question, 
    required this.state,
  });
  final RecallLabLoaded state;
  final QuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColours.glassBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColours.textPrimary.withValues(alpha:0.02),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              question.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColours.textPrimary,
                fontSize: 19,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            
            // Animated Solution Expansion Box
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: state.answerRevealed
                  ? Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Divider(height: 1, color: AppColours.glassBorder),
                        ),
                        Text(
                          'CORRECT SOLUTION',
                          style: TextStyle(
                            color: AppColours.textMuted,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          question.solution,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColours.textSecondary,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}
