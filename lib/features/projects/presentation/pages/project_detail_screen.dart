import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_event.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_state.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_section_header.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_tile.dart';
import 'package:forge_recall/features/projects/presentation/widgets/add_topic_button.dart';
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

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final position = _scrollController.position;

    final nearBottom =
        position.pixels >
        position.maxScrollExtent - 200;

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

  void _addTopic() {
    debugPrint('Add topic');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),

      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _showFab
            ? FloatingActionButton.extended(
                key: const ValueKey('fab'),
                heroTag: 'add_topic',
                onPressed: _addTopic,
                icon: const Icon(Icons.add),
                label: const Text('Add Topic'),
              )
            : const SizedBox.shrink(),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(height: 18),
            
                        ProjectDetailHeroSection(
                          project: project,
                        ),
            
                        const SizedBox(height: 26),
            
                        ProjectMasteryCard(
                          project: project,
                        ),
            
                        const SizedBox(height: 30),
                       //#########TopicBloc######################
                       
                        const TopicSectionHeader(),
            
                        const SizedBox(height: 20),
            
                        TopicTile(
                          title: 'Cellular Respiration',
                          mastery: 72,
                          questions: 28,
                          difficulty: 'Advanced',
                        ),
            
                        const SizedBox(height: 16),
            
                        TopicTile(
                          title:
                              'Electrochemical Gradients',
                          mastery: 41,
                          questions: 16,
                          difficulty: 'Expert',
                        ),
            
                        const SizedBox(height: 16),
            
                        TopicTile(
                          title:
                              'Quantum Wave Functions',
                          mastery: 18,
                          questions: 9,
                          difficulty: 'Expert',
                        ),
            
                        const SizedBox(height: 22),
            
                        const SizedBox(height: 26),
            
                        AnimatedSwitcher(
                          duration:
                              const Duration(milliseconds: 300),
                          child: !_showFab
                              ? AddTopicButton(
                                  key: const ValueKey(
                                      'bottom_button'),
                                  onTap: _addTopic,
                                )
                              : const SizedBox.shrink(),
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
                // Print it to your debug console so you can read the full trace
                debugPrint('SINGLE PROJECT ERROR: ${projectState.message}'); 
                
                // Show it on the screen temporarily so you can see it
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
