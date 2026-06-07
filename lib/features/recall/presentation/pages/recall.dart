import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_bloc.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_event.dart';
import 'package:forge_recall/features/recall/presentation/widgets/recall_modes.dart';
import 'package:forge_recall/features/recall/presentation/widgets/recall_hero_card.dart';
import 'package:forge_recall/features/recall/presentation/widgets/recall_session_stats.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';


class RecallPage extends StatelessWidget {
  final List<QuestionEntity> questions;

  const RecallPage({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.obsidian,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HEADER
              Text(
                "RECALL",
                style: AppTypography.headlineLarge,
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2),

              const SizedBox(height: 8),

              Text(
                "ENTER ACTIVE MEMORY TRAINING",
                style: AppTypography.body.copyWith(
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 32),

              // HERO CARD
              RecallHeroCard(),
              const SizedBox(height: 32),

              // MODES TITLE
              Text(
                "TRAINING MODES",
                style: AppTypography.body.copyWith(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              // MODES
              const RecallModes(),
              const SizedBox(height: 36),

              // RECALLSESSION STATS
              const RecallSessionStats(),
              const SizedBox(height: 40),

              // PRIMARY ACTION
              GestureDetector(
                onTap: () {
                  context.read<RecallLabBloc>().add(
                    StartRecallSessionEvent(
                      questions,
                    ),
                  );

                  context.push(
                    '/recall-session',
                    extra: questions,
                  );
                },

                child: Container(
                  height: 62,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    gradient: const LinearGradient(
                      colors: [
                        AppColours.electricBlue,
                        Color(0xFF306BFF),
                      ],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: AppColours.electricBlue.withValues(alpha: 0.35),
                        blurRadius: 24,
                      ),
                    ],
                  ),

                  child: Center(
                    child: Text(
                      "BEGIN RECALL SESSION",
                      style: AppTypography.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    duration: 3000.ms,
                    delay: 2000.ms,
                  ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
