import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_event.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

void showAddEditDialog(BuildContext context, TopicEntity topic, {QuestionEntity? existingQuestion}) {
  final isEditing = existingQuestion != null;
  final questionController = TextEditingController(text: existingQuestion?.question ?? '');
  final answerController = TextEditingController(text: existingQuestion?.solution ?? '');

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: AppColours.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titlePadding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        actionsPadding: const EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 12),
        title: Text(
          isEditing ? 'Edit Question' : 'Add Question',
          style: const TextStyle(
            color: AppColours.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Question',
                  style: TextStyle(color: AppColours.textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: questionController,
                  maxLines: 3,
                  style: const TextStyle(color: AppColours.textPrimary, fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Enter question text...',
                    hintStyle: const TextStyle(color: AppColours.textMuted),
                    filled: true,
                    fillColor: AppColours.surfaceSecondary,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColours.electricBlue, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Answer',
                  style: TextStyle(color: AppColours.textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: answerController,
                  maxLines: 3,
                  style: const TextStyle(color: AppColours.textPrimary, fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Enter correct response details...',
                    hintStyle: const TextStyle(color: AppColours.textMuted),
                    filled: true,
                    fillColor: AppColours.surfaceSecondary,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColours.violet, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            style: TextButton.styleFrom(
              foregroundColor: AppColours.textSecondary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: AppColours.geminiGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: () {
                final newQuestion = QuestionEntity(
                  id: isEditing ? existingQuestion.id : DateTime.now().millisecondsSinceEpoch.toString(),
                  question: questionController.text.trim(),
                  solution: answerController.text.trim(),
                );

                if (isEditing) {
                  context.read<QuestionsBloc>().add(UpdateQuestionEvent(newQuestion));
                } else {
                  context.read<QuestionsBloc>().add(
                        AddQuestionEvent(
                          projectId: topic.projectId,
                          topicId: topic.id,
                          question: newQuestion,
                        ),
                      );
                }

                Navigator.of(dialogContext).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    },
  );
}
