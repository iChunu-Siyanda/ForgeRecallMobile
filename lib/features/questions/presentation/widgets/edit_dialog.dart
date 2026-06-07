import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_event.dart';

void showAddEditDialog(BuildContext context, {QuestionEntity? existingQuestion}) {
  final isEditing = existingQuestion != null;
  final questionController = TextEditingController(text: existingQuestion?.question ?? '');
  final answerController = TextEditingController(text: existingQuestion?.solution ?? '');

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(isEditing ? 'Edit Question' : 'Add Question'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: answerController,
                decoration: const InputDecoration(
                  labelText: 'Answer',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newQuestion = QuestionEntity(
                id: isEditing ? existingQuestion.id : DateTime.now().toString(), // Generate an ID if new
                question: questionController.text,
                solution: answerController.text,
              );

              if (isEditing) {
                context.read<QuestionsGenerationBloc>().add(UpdateQuestionEvent(newQuestion));
              } else {
                context.read<QuestionsGenerationBloc>().add(AddQuestionEvent(newQuestion));
              }

              Navigator.of(dialogContext).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
