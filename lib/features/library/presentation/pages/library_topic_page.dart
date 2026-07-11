import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/shared/entites/topic_filter.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/library/presentation/bloc/library_bloc.dart';
import 'package:forge_recall/features/library/presentation/bloc/library_state.dart';
import 'package:forge_recall/features/library/presentation/widgets/library_topic_card.dart';

class LibraryTopicsPage extends StatelessWidget {
  final String title;
  final TopicFilter filter;

  const LibraryTopicsPage({
    super.key,
    required this.title,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background, // Maintain consistent canvas background
      appBar: AppBar(
        backgroundColor: AppColours.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColours.textPrimary),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColours.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          if (state is LibraryLoading) {
            return const Center(
              child: SizedBox(
                width: 40,
                height: 40,
                // A clean, electric blue loading indicator matching Material standards
                child: CircularProgressIndicator(
                  strokeWidth: 3.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                  backgroundColor: AppColours.surfaceSecondary,
                ),
              ),
            );
          }

          if (state is LibraryLoaded) {
            final topics = state.topics;

            if (topics.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColours.surfaceSecondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        size: 40,
                        color: AppColours.textMuted,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No topics found',
                      style: TextStyle(
                        color: AppColours.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Topics you add or study will appear here.',
                      style: TextStyle(
                        color: AppColours.textMuted,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: topics.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16), // Balanced spacing
              itemBuilder: (context, index) {
                final topic = topics[index];
                return LibraryTopicCard(
                  topic: topic,
                  onTap: () {
                    // Navigate to individual topic detail view when tapped
                  },
                );
              },
            );
          }

          if (state is LibraryError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColours.crimson.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.error_outline_rounded,
                        size: 40,
                        color: AppColours.crimson,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(
                        color: AppColours.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColours.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
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
