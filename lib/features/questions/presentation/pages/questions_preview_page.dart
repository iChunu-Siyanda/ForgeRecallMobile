import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_state.dart';
import 'package:go_router/go_router.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_state.dart';
import 'package:forge_recall/features/questions/presentation/widgets/edit_dialog.dart';
import 'package:forge_recall/features/questions/presentation/widgets/question_card.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
// Ensure your AppColours path is imported correctly here
// import 'path_to_your_colors/app_colours.dart';

class QuestionsPreviewPage extends StatefulWidget {
  final TopicEntity topic;
  final String note;

  const QuestionsPreviewPage({
    super.key,
    required this.topic,
    required this.note,
  });

  @override
  State<QuestionsPreviewPage> createState() => _QuestionsPreviewPageState();
}

class _QuestionsPreviewPageState extends State<QuestionsPreviewPage> {
  @override
  void initState() {
    super.initState();
    context.read<QuestionsGenerationBloc>().add(GenerateQuestionsEvent(widget.note));
  }

  void _handleSaveQuestions(BuildContext context) {
    context.read<QuestionsBloc>().add(
      SaveQuestionsEvent(
        projectId: widget.topic.projectId,
        topicId: widget.topic.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsBloc, QuestionsState>(
      listener: (context, state) {
        debugPrint('QuestionsPreviewPage: ${state.runtimeType}');
        if (state is QuestionsSaveSuccess) {
          context.push(AppRoutes.recallSession, extra: widget.topic);
        }

        if (state is QuestionsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColours.crimson,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColours.background,
        appBar: AppBar(
          backgroundColor: AppColours.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          shape: const Border(
            bottom: BorderSide(color: AppColours.glassBorder, width: 1.5),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColours.textPrimary, size: 20),
            onPressed: () {
              context.pop();
            },
          ),
          title: const Text(
            'Generated Questions',
            style: TextStyle(
              color: AppColours.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<QuestionsGenerationBloc, QuestionsGenerationState>(
                builder: (context, state) {
                  if (state is QuestionsInitial || state is QuestionsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                      ),
                    );
                  }

                  if (state is QuestionsError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline_rounded, color: AppColours.crimson, size: 44),
                            const SizedBox(height: 12),
                            Text(
                              state.message,
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

                  if (state is QuestionsLoaded || state is QuestionsSaving) {
                    final questions = state is QuestionsLoaded 
                        ? state.questions 
                        : (state as QuestionsSaving).questions;

                    if (questions.isEmpty) {
                      return const Center(
                        child: Text(
                          'No questions generated yet.',
                          style: TextStyle(color: AppColours.textMuted, fontSize: 15),
                        ),
                      );
                    }

                    return Stack(
                      children: [
                        ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: questions.length + 1,
                          separatorBuilder: (_, _) => const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            if (index == questions.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    showAddEditDialog(context, widget.topic);
                                  },
                                  icon: const Icon(Icons.add_rounded, size: 18),
                                  label: const Text('Add Custom Question'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColours.electricBlue,
                                    side: const BorderSide(color: AppColours.glassBorder, width: 1.5),
                                    backgroundColor: AppColours.surface,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              );
                            }

                            final question = questions[index];

                            return QuestionCard(
                              index: index + 1,
                              question: question,
                              topic: widget.topic,
                            );
                          },
                        ),
                        if (state is QuestionsSaving)
                          Container(
                            color: AppColours.textPrimary.withValues(alpha: 0.3),
                            child: const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(AppColours.violet),
                              ),
                            ),
                          ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            Container(
              color: AppColours.surface,
              decoration: BoxDecoration(
                border: const Border(top: BorderSide(color: AppColours.glassBorder, width: 1)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: BlocBuilder<QuestionsGenerationBloc, QuestionsGenerationState>(
                      builder: (context, state) {
                        final isSaving = state is QuestionsSaving;

                        return Container(
                          decoration: BoxDecoration(
                            gradient: isSaving ? null : AppColours.geminiGradient,
                            color: isSaving ? AppColours.surfaceSecondary : null,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: isSaving ? null : () => _handleSaveQuestions(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              disabledBackgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isSaving
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(AppColours.textMuted),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Saving...',
                                        style: TextStyle(color: AppColours.textMuted, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'Save Questions',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: -0.1,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
