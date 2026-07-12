import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/shared/registrations/register_projects_module.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/core/widgets/bloc_error_widget.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_state.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/presentation/widgets/add_question_sheet.dart.dart';
import 'package:forge_recall/features/topics/presentation/widgets/custom_questions_card.dart';
import 'package:forge_recall/features/topics/presentation/widgets/empty_knowledge_card.dart';
import 'package:forge_recall/features/topics/presentation/widgets/material_summary_car.dart';
import 'package:forge_recall/features/topics/presentation/widgets/method_sheet.dart';
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
      showDragHandle: false,
      backgroundColor: AppColours.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return MethodSheet(topic: topic);
      },
    );
  }

  void _showAddQuestionSheet(BuildContext context) {
    final questionController = TextEditingController();
    final answerController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColours.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: BlocProvider(
            create: (_) => getIt<QuestionsBloc>(),
            child: AddQuestionSheet(
              questionController: questionController, 
              answerController: answerController, 
              topic: topic,
            ),
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background, // Clean ambient workspace background
      appBar: AppBar(
        backgroundColor: AppColours.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        shape: const Border(
          bottom: BorderSide(
            color: AppColours.glassBorder, 
            width: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () { 
            context.pop();
          }, 
          // Swapped to the modern, centered iOS arrow asset
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded, 
            color: AppColours.textSecondary,
            size: 18,
          ),
        ),
        title: Text(
          topic.title,
          style: const TextStyle(
            color: AppColours.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
          ),
        ),
      ),
      body: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (BuildContext context, QuestionsState state) {
          debugPrint('Entered TopicKnowledgePage');
          if (state is QuestionsInitialState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                strokeWidth: 3,
              ),
            );
          }

          if (state is QuestionsLoadedState) {
            final questions = state.topicQuestions;
            
            return SingleChildScrollView(
              // Consistent workspace padding gutters
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Material Summary Card or Empty Slate Section
                  questions.isEmpty 
                      ? EmptyKnowledgeCard(
                          onAddMaterial: () => _showInputMethodSheet(context),
                        ) 
                      : MaterialSummaryCard(
                          questionCount: questions.length,
                          onEditMaterial: () {
                            context.push(AppRoutes.notesInput, extra: topic);
                          },
                          onPreviewQuestions: () {
                            context.push(AppRoutes.recallSession, extra: topic);
                          },
                        ),
              
                  const SizedBox(height: 16),
            
                  // Bottom Actions Area
                  CustomQuestionsCard(
                    onAddQuestion: () => _showAddQuestionSheet(context),
                  ),
                ],
              ),
            );
          }

          if (state is QuestionsErrorState) {
            return BlocErrorWidget(message: state.message);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

//This page deals with:
// Notes
// Generated questions
// Custom questions
// Recall statistics