import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_button.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_card.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_section_title.dart';
import 'package:forge_recall/features/projects/presentation/widgets/projects_header.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'Flutter Development',
        'mastery': 72,
        'topics': 48,
        'due': 12,
        'color': const Color(0xFF4D8DFF),
      },
      {
        'title': 'Calculus',
        'mastery': 41,
        'topics': 27,
        'due': 19,
        'color': const Color(0xFFFF7A00),
      },
      {
        'title': 'Thermodynamics',
        'mastery': 63,
        'topics': 33,
        'due': 7,
        'color': const Color(0xFF2ECC71),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // HEADER
              const ProjectsHeader(),
              const SizedBox(height: 30),

              // CREATE PROJECT BUTTON
              const ProjectButton(),
              const SizedBox(height: 30),

              // SECTION TITLE
              const ProjectSectionTitle(),
              const SizedBox(height: 20),

              // PROJECTS LIST
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: projects.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 22),
                  itemBuilder: (context, index) {
                    final project = projects[index];

                    return ProjectCard(
                      title: project['title'] as String,
                      mastery: project['mastery'] as int,
                      topics: project['topics'] as int,
                      due: project['due'] as int,
                      accentColor: project['color'] as Color,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
