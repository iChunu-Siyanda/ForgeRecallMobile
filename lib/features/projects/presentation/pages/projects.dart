import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_bloc.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_event.dart';
import 'package:forge_recall/features/projects/presentation/bloc/project_state.dart';
import 'package:forge_recall/features/projects/presentation/widgets/create_project_modal.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_button.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_card.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_section_title.dart';
import 'package:forge_recall/features/projects/presentation/widgets/projects_header.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<ProjectBloc>().add(LoadProjectsEvent(user!.uid));
  }

  @override
  Widget build(BuildContext context) {
    final projectBloc = context.read<ProjectBloc>();
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<ProjectBloc,ProjectState>(
            builder:(context, state) {
              if (state is ProjectLoadingState) {
                return const Center(child: CircularProgressIndicator(),);
              }

              if (state is ProjectsLoadedState) {
                final projects = state.projects;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProjectsHeader(),
                    const SizedBox(height: 20),
                    const ProjectSectionTitle(title: 'Your Projects'),
                    const SizedBox(height: 10),
                    Expanded(
                      child: projects.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_off_rounded, size: 64, color: Colors.grey),
                                  SizedBox(height: 16),
                                  Text(
                                    "You don't have any projects yet.",
                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                  ),
                                  Text(
                                    "Tap below to create your first one!",
                                    style: TextStyle(color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                            )
                        :ListView.builder(
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            final project = projects[index];
                            return GestureDetector(
                              onTap: () {
                                context.go('/projectDetail/${project.id}');
                              },
                              child: ProjectCard(
                                title: project.title, 
                                mastery: project.masteryPercentage, 
                                topics: project.totalTopics, 
                                due: 5,
                                accentColor: Colors.deepPurple,),
                            );
                          },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ProjectButton(
                      projectBtnText: 'Create New Project',
                      projectBtnOnTap: (){
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          //useRootNavigator: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) {
                            return DraggableScrollableSheet(
                              initialChildSize: 0.65,
                              minChildSize: 0.45,
                              maxChildSize: 0.9,
                              expand: false,
                              builder: (context, scrollController) {
                                return CreateProjectModal(projectBloc: projectBloc,);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }

              if (state is ProjectErrorState) {
                // Print it to your debug console so you can read the full trace
                debugPrint('PROJECTS ERROR: ${state.message}'); 
                
                // Show it on the screen temporarily so you can see it
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
