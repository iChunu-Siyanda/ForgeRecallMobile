import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_event.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_state.dart';
import 'package:forge_recall/features/projects/presentation/widgets/pds_floating_action_button.dart';
import 'package:forge_recall/features/projects/presentation/widgets/pds_hero_section.dart';
import 'package:forge_recall/features/projects/presentation/widgets/pds_sliver_app_bar.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_event.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topics_state.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_empty_state.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_tile.dart';
// Assuming AppColours is imported from your theme directory:
// import 'package:your_app/theme/app_colours.dart'; 

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectBloc>().add(GetSingleProjectEvent(widget.projectId));
    context.read<TopicBloc>().add(LoadTopics(widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Updated to Gemini light workspace background
      backgroundColor: AppColours.background,
      
      // 2. Transformed addTopic button into an elegant standard FloatingActionButton with the signature gradient
      floatingActionButton: PdsFloatingActionBtn(widget: widget),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, projectState) {
          if (projectState is ProjectLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
              ),
            );
          }

          if (projectState is ProjectLoadedState) {
            final project = projectState.project;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                PdsSliverAppBar(project: project),
                PdsHeroSection(project: project),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: BlocBuilder<TopicBloc, TopicState>(
                    builder: (context, topicState) {
                      if (topicState is TopicLoading) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                            ),
                          ),
                        );
                      }

                      if (topicState is TopicLoaded) {
                        final topics = topicState.topics;

                        if (topics.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Center(child: TopicEmptyState()),
                          );
                        }

                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final topic = topics[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TopicTile(topic: topic),
                              );
                            },
                            childCount: topics.length,
                          ),
                        );
                      }

                      if (topicState is TopicError) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              topicState.message,
                              style: const TextStyle(color: AppColours.crimson), // Replaced raw Colors.red with crimson
                            ),
                          ),
                        );
                      }

                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    },
                  ),
                ),
                // Removed the old inline PdsAddTopicBtn sliver entirely
              ],
            );
          }

          if (projectState is ProjectErrorState) {
            debugPrint('SINGLE PROJECT ERROR: ${projectState.message}');

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${projectState.message}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColours.crimson), // Replaced raw Colors.red with crimson
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
