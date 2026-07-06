import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/core/shared/entites/topic_filter.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/library/presentation/widgets/continue_studying_card.dart';
import 'package:forge_recall/features/library/presentation/widgets/library_tile.dart';

class LibraryPage extends StatelessWidget {
  //LibraryPage -> LibraryBloc -> GetLibraryUseCase -> TopicRepository -> Firestore
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        centerTitle: false,
        leading: IconButton(onPressed: () {
            MainNavigation.openDrawer(context);
          }, 
          icon: const Icon(Icons.menu, color: AppColours.textPrimary),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ContinueStudyingCard(),

          SizedBox(height: 24),

          Text(
            'Browse',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 16),

          LibraryTile(
            icon: Icons.folder_outlined,
            title: 'Projects',
            subtitle: 'Browse your learning projects',
            filter: TopicFilter.allTopics,
          ),

          LibraryTile(
            icon: Icons.menu_book_outlined,
            title: 'All Topics',
            subtitle: 'Every topic you have created', 
            filter: TopicFilter.allTopics,
          ),

          LibraryTile(
            icon: Icons.star_border,
            title: 'Favorites',
            subtitle: 'Topics you have starred',
            filter: TopicFilter.favorites,
          ),

          LibraryTile(
            icon: Icons.history,
            title: 'Recently Studied',
            subtitle: 'Continue where you left off',
            filter: TopicFilter.recent,
          ),

          LibraryTile(
            icon: Icons.local_fire_department_outlined,
            title: 'Difficult Topics',
            subtitle: 'Topics needing more practice',
            filter: TopicFilter.difficult,
          ),

          LibraryTile(
            icon: Icons.check_circle_outline,
            title: 'Completed Topics',
            subtitle: 'Topics you have mastered',
            filter: TopicFilter.completed,
          ),

          LibraryTile(
            icon: Icons.quiz_outlined,
            title: 'Saved Questions',
            subtitle: 'Questions you have bookmarked',
            filter: TopicFilter.favorites,
          ),
        ],
      ),
    );
  }
}

