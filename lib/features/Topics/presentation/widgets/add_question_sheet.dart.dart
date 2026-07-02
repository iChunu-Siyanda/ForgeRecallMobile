import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_event.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class AddQuestionSheet extends StatelessWidget {
  const AddQuestionSheet({
    super.key,
    required this.questionController,
    required this.answerController,
    required this.topic,
  });

  final TextEditingController questionController;
  final TextEditingController answerController;
  final TopicEntity topic;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Add Custom Question',
            style: TextStyle(
              color: AppColours.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Question Input Field
        Text(
          'Question',
          style: TextStyle(color: AppColours.textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: questionController,
          maxLines: 3,
          style: const TextStyle(color: AppColours.textPrimary, fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Enter your recall question...',
            hintStyle: const TextStyle(color: AppColours.textMuted),
            filled: true,
            fillColor: AppColours.surfaceSecondary,
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColours.electricBlue, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 18),
    
        // Answer Input Field
        Text(
          'Answer',
          style: TextStyle(color: AppColours.textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: answerController,
          maxLines: 4,
          style: const TextStyle(color: AppColours.textPrimary, fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Enter the correct response details...',
            hintStyle: const TextStyle(color: AppColours.textMuted),
            filled: true,
            fillColor: AppColours.surfaceSecondary,
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColours.violet, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 28),
    
        // Gemini Gradient Action Save Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColours.geminiGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed: () {
              final question = QuestionEntity(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                question: questionController.text.trim(),
                solution: answerController.text.trim(),
              );
    
              context.read<QuestionsBloc>().add(
                AddQuestionEvent(
                  question: question,
                  projectId: topic.projectId,
                  topicId: topic.id,
                ),
              );
    
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save Question',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
