import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/core/shared/entites/topic_filter.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/library/domain/entites/library_topic_params.dart';
import 'package:forge_recall/features/library/presentation/widgets/continue_studying_card.dart';
import 'package:forge_recall/features/library/presentation/widgets/library_tile.dart';
import 'package:go_router/go_router.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        centerTitle: false,
        leading: IconButton(
          onPressed: () => MainNavigation.openDrawer(context),
          icon: const Icon(
            Icons.menu,
            color: AppColours.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ContinueStudyingCard(),

          const SizedBox(height: 32),
          
          //Topics
          const _SectionHeader('Knowledge'),
          const SizedBox(height: 16),

          LibraryTile(
            icon: Icons.menu_book_outlined,
            title: 'All Topics',
            subtitle: 'Browse every topic you have created',
            onTapNav: () => _goToTopics(context,TopicFilter.allTopics,'All Topics'),
          ),

          LibraryTile(
            icon: Icons.star_border,
            title: 'Favorite Topics',
            subtitle: 'Topics you have starred',
            onTapNav: () => _goToTopics(context,TopicFilter.favorites,'Favorite Topics'),
          ),

          LibraryTile(
            icon: Icons.history,
            title: 'Recently Studied',
            subtitle: 'Continue where you left off',
            onTapNav: () => _goToTopics(context,TopicFilter.recent,'Recently Studied'),
          ),

          LibraryTile(
            icon: Icons.local_fire_department_outlined,
            title: 'Advanced Topics',
            subtitle: 'Topics that need more practice',
            onTapNav: () => _goToTopics(context,TopicFilter.difficult,'Advanced Topics'),
          ),

          LibraryTile(
            icon: Icons.check_circle_outline,
            title: 'Completed Topics',
            subtitle: 'Topics you have mastered',
            onTapNav: () => _goToTopics(context,TopicFilter.completed,'Completed Topics'),
          ),

          const SizedBox(height: 32),

          // Projects
          const _SectionHeader('Projects'),
          const SizedBox(height: 16),

          LibraryTile(
            icon: Icons.folder_outlined,
            title: 'All Projects',
            subtitle: 'Browse all your learning projects', 
            onTapNav: () {},
          ),

          const SizedBox(height: 32),

          // Questions
          const _SectionHeader('Questions'),
          const SizedBox(height: 16),

          LibraryTile(
            icon: Icons.quiz_outlined,
            title: 'Saved Questions',
            subtitle: 'Questions you have bookmarked', 
            onTapNav: () {  },
          ),
        ],
      ),
    );
  }
}

void _goToTopics(BuildContext context, TopicFilter topic, String title){
  context.push(
  AppRoutes.libraryTopic, 
  extra: LibraryTopicParams(
    filter: topic,
    title: title,
    ),
  );
}
  

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
