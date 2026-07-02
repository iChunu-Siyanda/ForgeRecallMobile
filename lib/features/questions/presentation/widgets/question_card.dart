import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_event.dart';
import 'package:forge_recall/features/questions/presentation/widgets/edit_dialog.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class QuestionCard extends StatelessWidget {
  final int index;
  final QuestionEntity question;
  final TopicEntity topic;

  const QuestionCard({
    super.key,
    required this.index,
    required this.question,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColours.glassBorder, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question $index',
                  style: const TextStyle(
                    color: AppColours.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColours.surfaceSecondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    color: AppColours.geminiPurple,
                    size: 18,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, thickness: 1, color: AppColours.glassBorder),
            ),
            Text(
              question.question,
              style: const TextStyle(
                color: AppColours.textPrimary,
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'ANSWER',
              style: TextStyle(
                color: AppColours.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              question.solution,
              style: const TextStyle(
                color: AppColours.textSecondary,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => showAddEditDialog(context, topic, existingQuestion: question),
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text('Edit', style: TextStyle(fontWeight: FontWeight.w600)),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColours.electricBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 4),
                TextButton.icon(
                  onPressed: () {
                    context.read<QuestionsBloc>().add(DeleteQuestionEvent(question.id));
                  },
                  icon: const Icon(Icons.delete_outline_rounded, size: 16),
                  label: const Text('Delete', style: TextStyle(fontWeight: FontWeight.w600)),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColours.crimson,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
