import 'package:flutter/material.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_empty_state.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_section_header.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_tile.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/presentation/widgets/add_topic_button.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_detail_hero_section.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_mastery_card.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    debugPrint('Entered ProjectDetailScreen with project: ${project.title}');
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
             expandedHeight: 140,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/projects');
                }
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: 24,
                bottom: 18,
              ),
              title: Text(
                project.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF111827),
                          Color(0xFF070B14),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: -50,
                    right: -40,
                    child: Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple.withValues(alpha: 0.18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              //physics: const BouncingScrollPhysics(),
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 18),

                  // HERO SECTION
                  ProjectDetailHeroSection(project: project),

                  const SizedBox(height: 26),

                  //MASTERY
                  ProjectMasteryCard(project: project),

                  const SizedBox(height: 30),

                  // TOPICS HEADER
                  const TopicSectionHeader(),

                  const SizedBox(height: 20),

                  // TOPICS LIST
                  TopicTile(
                    title: 'Cellular Respiration',
                    mastery: 72,
                    questions: 28,
                    difficulty: 'Advanced',
                  ),

                  const SizedBox(height: 16),

                  TopicTile(
                    title: 'Electrochemical Gradients',
                    mastery: 41,
                    questions: 16,
                    difficulty: 'Expert',
                  ),

                  const SizedBox(height: 16),

                   TopicTile(
                    title: 'Quantum Wave Functions',
                    mastery: 18,
                    questions: 9,
                    difficulty: 'Expert',
                  ),

                  const SizedBox(height: 22),

                  /// EMPTY STATE
                  const TopicEmptyState(),

                  const SizedBox(height: 26),

                  // CTA
                  AddTopicButton(
                    onTap: () {},
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),

        ],
      
      ),
    );
  }
}