import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_state.dart';
import 'package:forge_recall/features/recall/domain/entities/recall_rating.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_bloc.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_event.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_state.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:go_router/go_router.dart';
// Ensure your AppColours path is imported correctly here
// import 'path_to_your_colors/app_colours.dart';

class RecallSessionPage extends StatelessWidget {
  final TopicEntity topic;

  const RecallSessionPage({
    super.key,
    required this.topic,
  });

  void _rateRecall(BuildContext context, RecallRating rating) {
    context.read<RecallLabBloc>().add(RateRecallEvent(rating));
    context.read<RecallLabBloc>().add(NextQuestionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsBloc, QuestionsState>(
      listener: (context, state) {
        if (state is QuestionsLoadedState) {
          debugPrint('Questions loaded: ${state.topicQuestions.length}');
          context.read<RecallLabBloc>().add(StartRecallSessionEvent(state.topicQuestions));
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
            icon: const Icon(Icons.close_rounded, color: AppColours.textSecondary, size: 24),
            onPressed: () {
              // Gracefully drop back out of workspace session
              context.pop();
            },
          ),
          title: Text(
            topic.title,
            style: const TextStyle(
              color: AppColours.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<QuestionsBloc, QuestionsState>(
            builder: (context, questionsState) {
              if (questionsState is QuestionsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                  ),
                );
              }

              if (questionsState is QuestionsErrorState) {
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

              return BlocConsumer<RecallLabBloc, RecallLabState>(
                listener: (context, state) {
                  if (state is RecallLabCompleted) {
                    context.go('/session-complete', extra: state);
                  }
                },
                builder: (context, state) {
                  if (state is RecallLabInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                      ),
                    );
                  }

                  if (state is RecallLabLoaded) {
                    if (state.questions.isEmpty) {
                      return const Center(
                        child: Text(
                          'No questions found.',
                          style: TextStyle(color: AppColours.textMuted, fontSize: 15),
                        ),
                      );
                    }

                    final question = state.currentQuestion;
                    final totalCount = state.questions.length;
                    final currentIdx = state.currentIndex + 1;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top Context Stats Tracking Panel
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SESSION PROGRESS',
                                style: TextStyle(
                                  color: AppColours.textMuted,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.6,
                                ),
                              ),
                              Text(
                                '$currentIdx of $totalCount',
                                style: const TextStyle(
                                  color: AppColours.textPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: currentIdx / totalCount,
                              minHeight: 6,
                              backgroundColor: AppColours.surfaceSecondary,
                              valueColor: const AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                            ),
                          ),

                          const Spacer(),

                          // Active Flashcard Canvas Area
                          Container(
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
                          ),

                          const Spacer(),

                          // Action Controller Placement Section
                          if (!state.answerRevealed)
                            Container(
                              height: 52,
                              decoration: BoxDecoration(
                                gradient: AppColours.geminiGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<RecallLabBloc>().add(RevealAnswerEvent());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text(
                                  'Reveal Answer',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                          if (state.answerRevealed)
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () => _rateRecall(context, RecallRating.forgot),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColours.crimson.withValues(alpha:0.12),
                                        foregroundColor: AppColours.crimson,
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(color: AppColours.crimson, width: 1),
                                        ),
                                      ),
                                      child: const Text('😵 Forgot', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: SizedBox(
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () => _rateRecall(context, RecallRating.partial),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColours.amber.withValues(alpha:0.12),
                                        foregroundColor: AppColours.amber,
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(color: AppColours.amber, width: 1),
                                        ),
                                      ),
                                      child: const Text('🤔 Partial', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: SizedBox(
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () => _rateRecall(context, RecallRating.easy),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColours.emerald.withValues(alpha:0.12),
                                        foregroundColor: AppColours.emerald,
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(color: AppColours.emerald, width: 1),
                                        ),
                                      ),
                                      child: const Text('😎 Easy', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
