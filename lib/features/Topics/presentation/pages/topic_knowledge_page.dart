import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_state.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_event.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/presentation/widgets/custom_questions_card.dart';
import 'package:forge_recall/features/topics/presentation/widgets/empty_knowledge_card.dart';
import 'package:forge_recall/features/topics/presentation/widgets/material_summary_car.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_stats_card.dart';
import 'package:go_router/go_router.dart';

class TopicKnowledgePage extends StatelessWidget {
  final TopicEntity topic;

  const TopicKnowledgePage({
    super.key,
    required this.topic,
  });

  void _showInputMethodSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 15,),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Input Method',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
          
                const SizedBox(height: 10),
          
                ListTile(
                  leading: const Icon(Icons.edit_note),
                  title: const Text('Type Notes'),
                  subtitle: const Text(
                    'Paste study material manually',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/notesInput',extra: topic,);
                  },
                ),
          
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Upload Image'),
                  subtitle: const Text('Coming Soon'),
                  enabled: false,
                ),
          
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: const Text('Upload PDF'),
                  subtitle: const Text('Coming Soon'),
                  enabled: false,
                ),
          
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddQuestionSheet(BuildContext context) {
    final questionController = TextEditingController();
    final answerController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text(
                'Add Custom Question',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 20),

              TextField(
                controller: questionController,
                decoration:const InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),

                maxLines: 3,
              ),

              const SizedBox(height: 16),

              TextField(
                controller: answerController,
                decoration:  const InputDecoration(
                  labelText: 'Answer',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    final question = QuestionEntity(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      question: questionController.text.trim(),
                      solution: answerController.text.trim(),
                    );

                    context.read<QuestionsGenerationBloc>().add(
                      AddQuestionEvent(question),
                    );

                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save Question',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
          onPressed: () { context.go('/projectDetail/${topic.projectId}');}, 
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(topic.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<QuestionsBloc,QuestionsState>(
          builder: (BuildContext context, QuestionsState state) {
            if (state is QuestionsInitialState) {
              return const Center(child: CircularProgressIndicator(),);
            }

            if (state is QuestionsLoadedState) {
              final questions = state.topicQuestions;
              return Column(
                children: [
                  questions.isEmpty ?
                    EmptyKnowledgeCard(
                      onAddMaterial: () {
                        _showInputMethodSheet(context);
                      },
                    ) : MaterialSummaryCard(
                          questionCount: questions.length,
                          onEditMaterial: () {
                            context.go(
                              '/notesInput',
                              extra: topic,
                            );
                          },
                          onPreviewQuestions: () {
                            context.go(
                              '/recall-session',
                              extra: topic,
                            );
                          },
                        ),
                
                  const SizedBox(height: 16),
              
                  CustomQuestionsCard(
                    onAddQuestion: () {_showAddQuestionSheet(context);},
                  ),
              
                  const SizedBox(height: 16),
              
                  const TopicStatsCard(),
                ],
              );
            }

            if (state is QuestionsErrorState) {
              return Center(child: Text(state.message, style: TextStyle(color: Colors.red),),);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

//This page deals with:
// Notes
// Generated questions
// Custom questions
// Recall statistics