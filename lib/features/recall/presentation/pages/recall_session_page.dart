import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/recall/domain/entities/recall_rating.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_bloc.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_event.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_state.dart';
import 'package:go_router/go_router.dart';

class RecallSessionPage extends StatelessWidget {
  const RecallSessionPage({super.key});

  void _rateRecall(
    BuildContext context,
    RecallRating rating,
  ) {
    context.read<RecallLabBloc>().add(RateRecallEvent(rating),);
    context.read<RecallLabBloc>().add(NextQuestionEvent(),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RecallLabBloc, RecallLabState>(
          listener: (context, state) {
            if (state is RecallLabCompleted) {
              context.go(
                '/session-complete',
                extra: state,
              );
            }
          },
          builder: (context, state) {
            if (state is RecallLabInitial) {
              return const Center(child: CircularProgressIndicator(),);
            }

            if (state is RecallLabLoaded) {
              final question = state.currentQuestion;

              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.stretch,
                  children: [
                    // Progress
                    Text(
                      'Question ${state.currentIndex + 1} of ${state.questions.length}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    const SizedBox(height: 24),

                    LinearProgressIndicator(value: (state.currentIndex + 1) /state.questions.length,),

                    const Spacer(),

                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Text(
                              question.question,
                              textAlign:TextAlign.center,
                              style:Theme.of(context).textTheme.headlineSmall,
                            ),

                            const SizedBox(height: 24,),

                            if (state.answerRevealed)
                              Column(
                                children: [
                                  const Divider(),
                                  const SizedBox(height: 16,),

                                  Text(
                                    'Answer',
                                    style:Theme.of(context,).textTheme.titleMedium,
                                  ),

                                  const SizedBox(height: 12,),

                                  Text(
                                    question.solution,
                                    textAlign:TextAlign.center,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    if (!state.answerRevealed)
                      FilledButton(
                        onPressed: () {
                          context.read<RecallLabBloc>().add(RevealAnswerEvent(),);
                        },
                        child: const Text('Reveal Answer',),
                      ),

                    if (state.answerRevealed)
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () {_rateRecall(context, RecallRating.forgot);},
                              child: const Text('😵 Forgot',),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: FilledButton(
                              onPressed: () {_rateRecall(context, RecallRating.partial);},
                              child: const Text('🤔 Partial',),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: FilledButton(
                              onPressed: () {_rateRecall(context, RecallRating.easy);},
                              child: const Text('😎 Easy',),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }

            if (state is RecallLabCompleted) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.emoji_events,size: 72,),
                      const SizedBox(height: 24,),

                      Text(
                        'Session Complete',
                        style:Theme.of(context).textTheme.headlineMedium,
                      ),

                      const SizedBox(height: 24,),

                      Text('Questions Reviewed: ${state.totalQuestions}',),

                      const SizedBox(height: 12,),

                      Text('😎 Easy: ${state.easyCount}',),

                      Text('🤔 Partial: ${state.partialCount}',),

                      Text('😵 Forgot: ${state.forgotCount}',),

                      const SizedBox(height: 32,),

                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context,);
                        },
                        child: const Text('Finish',),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
