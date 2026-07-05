import 'package:flutter/material.dart';
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
          ),

          LibraryTile(
            icon: Icons.menu_book_outlined,
            title: 'All Topics',
            subtitle: 'Every topic you have created',
          ),

          LibraryTile(
            icon: Icons.star_border,
            title: 'Favorites',
            subtitle: 'Topics you have starred',
          ),

          LibraryTile(
            icon: Icons.history,
            title: 'Recently Studied',
            subtitle: 'Continue where you left off',
          ),

          LibraryTile(
            icon: Icons.local_fire_department_outlined,
            title: 'Difficult Topics',
            subtitle: 'Topics needing more practice',
          ),

          LibraryTile(
            icon: Icons.check_circle_outline,
            title: 'Completed Topics',
            subtitle: 'Topics you have mastered',
          ),

          LibraryTile(
            icon: Icons.quiz_outlined,
            title: 'Saved Questions',
            subtitle: 'Questions you have bookmarked',
          ),
        ],
      ),
    );
  }
}

