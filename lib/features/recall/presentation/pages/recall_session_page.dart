import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_state.dart';
import 'package:forge_recall/features/recall/domain/entities/recall_rating.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_bloc.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_event.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_state.dart';
import 'package:forge_recall/features/recall/presentation/widgets/recall_flash_cards.dart';
import 'package:forge_recall/features/recall/presentation/widgets/recall_questins_empty.dart';
import 'package:forge_recall/features/recall/presentation/widgets/recall_questions_error.dart';
import 'package:forge_recall/features/recall/presentation/widgets/recall_session_app_bar.dart';
import 'package:forge_recall/features/recall/presentation/widgets/recall_stats_tracking.dart';
import 'package:forge_recall/features/recall/presentation/widgets/reveal_ans_btn.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:go_router/go_router.dart';

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: RecallSessionAppBar(topic: topic),
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
                return RecallQuestionsError(questionsState: questionsState,);
              }

              return BlocConsumer<RecallLabBloc, RecallLabState>(
                listener: (context, state) {
                  if (state is RecallLabCompleted) {
                    context.go(AppRoutes.sessionComplete, extra: state);
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
                      return RecallQuestionsEmpty();
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
                          RecallStatsTracking(currentIdx: currentIdx, totalCount: totalCount),

                          const Spacer(),

                          // Active Flashcard Canvas Area
                          RecallFlashCards(question: question, state: state,),

                          const Spacer(),

                          // Action Controller Placement Section
                          if (!state.answerRevealed) RevealAnsBtn(),

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
