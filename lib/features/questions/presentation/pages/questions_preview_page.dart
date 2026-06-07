import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_state.dart';
import 'package:forge_recall/features/questions/presentation/widgets/edit_dialog.dart';
import 'package:forge_recall/features/questions/presentation/widgets/question_card.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class QuestionsPreviewPage extends StatelessWidget {
  final TopicEntity topic;

  const QuestionsPreviewPage({
    super.key,
    required this.topic,
  });

  void _handleSaveQuestions(BuildContext context) {
    context.read<QuestionsGenerationBloc>().add(
      SaveQuestionsEvent(
        projectId: topic.projectId,
        topicId: topic.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsGenerationBloc,QuestionsGenerationState>(
      listener: (context, state) {
        if (state is QuestionsSaved) {
          context.go('/recall-lab');
        }

        if (state is QuestionsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Generated Questions'),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<QuestionsGenerationBloc,QuestionsGenerationState>(
                builder: (context, state) {
                  if (state is QuestionsInitial || state is QuestionsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is QuestionsError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is QuestionsLoaded || state is QuestionsSaving) {
                    final questions =
                        state is QuestionsLoaded ? state.questions : (state as QuestionsSaving).questions;

                    if (questions.isEmpty) {
                      return const Center(
                        child: Text(
                          'No questions generated yet.',
                        ),
                      );
                    }

                    return Stack(
                      children: [
                        ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: questions.length + 1,
                          separatorBuilder: (_, _) =>const SizedBox(height: 16,),
                          itemBuilder:
                              (context, index) {
                            if (index == questions.length) {
                              return OutlinedButton.icon(
                                onPressed: () {
                                  showAddEditDialog(context,);
                                },
                                icon: const Icon(Icons.add,),
                                label: const Text('Add Question',),
                              );
                            }

                            final question = questions[index];

                            return QuestionCard(
                              index: index + 1,
                              question: question,
                            );
                          },
                        ),

                        if (state is QuestionsSaving)
                          Container(
                            color: Colors.black26,
                            child: const Center(child: CircularProgressIndicator(),),
                          ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<QuestionsGenerationBloc,QuestionsGenerationState>(
                    builder: (context, state) {
                      final isSaving = state is QuestionsSaving;

                      return ElevatedButton(
                        onPressed: isSaving
                            ? null
                            : () =>
                                _handleSaveQuestions(context,),
                        style:
                            ElevatedButton.styleFrom(
                          padding:const EdgeInsets.symmetric(vertical: 16,),
                        ),
                        child: Text(
                          isSaving ? 'Saving...' : 'Save Questions',
                        ),
                      );
                    },
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