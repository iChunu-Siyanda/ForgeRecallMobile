import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_event.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_state.dart';
import 'package:forge_recall/features/projects/presentation/widgets/add_topic_button.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_event.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topics_state.dart';
import 'package:forge_recall/features/topics/presentation/widgets/add_topic.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_empty_state.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_section_header.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_tile.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_detail_hero_section.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_mastery_card.dart';
import 'package:go_router/go_router.dart';

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

      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        // We use transitionBuilder to make it fade and slightly scale
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        child: _showFab
            ? FloatingActionButton.extended(
                key: const ValueKey('fab_active'), // Unique key
                // heroTag: null, // Ensure Hero is disabled or removed
                onPressed: () => addTopic(context, widget.projectId),
                icon: const Icon(Icons.add),
                label: const Text('Add Topic'),
              )
            : const SizedBox.shrink(key: ValueKey('fab_hidden')), // Unique key
      ),

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
                              color: Colors.deepPurple.withValues(
                                alpha: 0.18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
             
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        ProjectDetailHeroSection(project: project),
                        const SizedBox(height: 26),
                        ProjectMasteryCard(project: project),
                        const SizedBox(height: 30),
                        const TopicSectionHeader(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

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
                                child: TopicTile(
                                  topic: topic,
                                ),
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
                
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 26),
                        SizedBox(
                          height: 60,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: !_showFab
                                ? AddTopicButton(
                                    key: const ValueKey('inline_btn_active'), // Unique key
                                    onTap: () => addTopic(context, widget.projectId),
                                  )
                                : const SizedBox.shrink(key: ValueKey('inline_btn_hidden')), // Unique key
                          ),
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
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
