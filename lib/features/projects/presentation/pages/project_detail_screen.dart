import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_event.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_state.dart';
import 'package:forge_recall/features/projects/presentation/widgets/pds_add_topic_btn.dart';
import 'package:forge_recall/features/projects/presentation/widgets/pds_floating_action_button.dart';
import 'package:forge_recall/features/projects/presentation/widgets/pds_hero_section.dart';
import 'package:forge_recall/features/projects/presentation/widgets/pds_sliver_app_bar.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_event.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topics_state.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_empty_state.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_tile.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  State<ProjectDetailScreen> createState() =>
      _ProjectDetailScreenState();
}

class _ProjectDetailScreenState
    extends State<ProjectDetailScreen> {
  final ScrollController _scrollController =
      ScrollController();

  bool _showFab = true;

  @override
  void initState() {
    super.initState();

    context.read<ProjectBloc>().add(GetSingleProjectEvent(widget.projectId),);
    context.read<TopicBloc>().add(LoadTopics(widget.projectId));

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    
    final position = _scrollController.position;

    // If the list is too short to scroll, just show the inline button
    if (position.maxScrollExtent <= 0) {
      if (_showFab) setState(() => _showFab = false);
      return;
    }

    // Because the height is locked, 100px is a perfectly stable threshold
    final nearBottom = position.pixels > position.maxScrollExtent - 100;

    if (_showFab == nearBottom) {
      setState(() {
        _showFab = !nearBottom;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      floatingActionButton: PdsFloatingActionBtn(showFab: _showFab, widget: widget),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, projectState) {
          if (projectState is ProjectLoadingState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (projectState is ProjectLoadedState){
            final project = projectState.project;
            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                PdsSliverAppBar(project: project),
             
                PdsHeroSection(project: project),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: BlocBuilder<TopicBloc,TopicState>(
                    builder: (context, topicState) {
                      if (topicState is TopicLoading) {
                        return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (topicState is TopicLoaded) {
                        final topics = topicState.topics; // Assuming your state holds a list

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
                                padding: const EdgeInsets.only(bottom: 16), // Replaces your SizedBox(height: 16)
                                child: TopicTile(topic: topic,),
                              );
                            },
                            childCount: topics.length,
                          ),
                        );
                      }

                      if (topicState is TopicError) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text(topicState.message, style: const TextStyle(color: Colors.red))),
                        );
                      }

                      return const SliverToBoxAdapter(child: SizedBox.shrink());  
                    }
                  ),
                ),
                
                PdsAddTopicBtn(showFab: _showFab, widget: widget),
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
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          return const SizedBox();
        }
      ),
    );
  }
}
