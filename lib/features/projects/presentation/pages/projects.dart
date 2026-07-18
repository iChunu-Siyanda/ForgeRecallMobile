import 'dart:ui'; // Crucial for ImageFilter blur effects
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_event.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_state.dart';
import 'package:forge_recall/features/projects/presentation/widgets/fab_create_project_modal.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_card.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_section_title.dart';
import 'package:forge_recall/features/projects/presentation/widgets/projects_header.dart';
import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:go_router/go_router.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  late ScrollController _scrollController;
  bool _showCollapsedTitle = false;
  final double _scrollThreshold = 50.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    context.read<ProjectBloc>().add(LoadProjectsEvent(user!.uid));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset >= _scrollThreshold && !_showCollapsedTitle) {
        setState(() {
          _showCollapsedTitle = true;
        });
      } else if (_scrollController.offset < _scrollThreshold && _showCollapsedTitle) {
        setState(() {
          _showCollapsedTitle = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectBloc = context.read<ProjectBloc>();
    
    return Scaffold(
      backgroundColor: AppColours.background,
      floatingActionButton: FabCreateProjectModal(projectBloc: projectBloc),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          debugPrint("Current state: ${state.runtimeType}");
          if (state is ProjectsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
              ),
            );
          }
            
          if (state is ProjectsLoadedState) {
            //debugPrint("Project count: ${state.projects.length}");
            final projectCards = state.projects;

            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.transparent, 
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.menu, color: AppColours.textPrimary),
                    onPressed: () {
                      MainNavigation.openDrawer(context);
                    },
                  ),
                  title: AnimatedOpacity(
                    opacity: _showCollapsedTitle ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 150),
                    child: const Text(
                      'PROJECTS',
                      style: TextStyle(
                        color: AppColours.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  
                  // This handles the real-time blur processing behind the bar elements
                  flexibleSpace: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _showCollapsedTitle ? 12.0 : 0.0,
                        sigmaY: _showCollapsedTitle ? 12.0 : 0.0,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: _showCollapsedTitle
                            ? AppColours.background.withValues(alpha: 0.65) // Frosted Tint
                            : AppColours.background, // Clean Solid Canvas
                      ),
                    ),
                  ),
                ),

                // Natural Large Header (Scrolls up natively)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 16.0),
                    child: ProjectsHeader(),
                  ),
                ),

                // Section Divider Title
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
                    child: ProjectSectionTitle(),
                  ),
                ),

                // Cards Matrix
                if (projectCards.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_off_rounded,
                            size: 64,
                            color: AppColours.textMuted.withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "You don't have any projects yet.",
                            style: TextStyle(
                              color: AppColours.textSecondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Tap + to create your first one!",
                            style: TextStyle(
                              color: AppColours.textMuted,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else 
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final projectCard = projectCards[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: GestureDetector(
                              onTap: () {
                                context.push(
                                  AppRoutes.projectDetail(TopicQuery(projectId: projectCard.project.id).projectId!),
                                );
                              },
                              child: ProjectCard(
                                title: projectCard.project.title,
                                mastery: projectCard.project.masteryPercentage,
                                topics: projectCard.project.totalTopics,
                                accentColor: projectCard.project.getProjectAccent, 
                                due: projectCard.dueTopics, 
                                lastStudied: projectCard.lastStudied, 
                                daysSinceStudy: projectCard.daysSinceStudy,
                              ),
                            ),
                          );
                        },
                        childCount: projectCards.length,
                      ),
                    ),
                  ),
                
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            );
          }
            
          if (state is ProjectsErrorState) {
            debugPrint('PROJECTS ERROR: ${state.message}'); 
            
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${state.message}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColours.crimson,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }
            
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
