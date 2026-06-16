import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/domain/entities/project_entity.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_detail_hero_section.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_mastery_card.dart';
import 'package:forge_recall/features/topics/presentation/widgets/topic_section_header.dart';

class PdsHeroSection extends StatelessWidget {
  const PdsHeroSection({
    super.key,
    required this.project,
  });

  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
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
    );
  }
}
