import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/library/presentation/widgets/library_topic_card.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_bloc.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_event.dart';
import 'package:forge_recall/features/search/presentation/bloc/search_state.dart';
import 'package:forge_recall/features/search/presentation/widgets/searc_error_page.dart';
import 'package:forge_recall/features/search/presentation/widgets/search_app_bar.dart';
import 'package:forge_recall/features/search/presentation/widgets/search_initial_card.dart';
import 'package:forge_recall/features/search/presentation/widgets/search_topic_loaded_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

 void _onSearchChanged(String query) {
    // 3. Cancel any scheduled search event if the user keeps typing
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // 4. Wait for 300ms of typing inactivity before dispatching to BLoC
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        context.read<SearchBloc>().add(SearchTopics(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SearchAppBar(),
      ),
      body: Column(
        children: [
          // Elegant search container styled to mirror Google's minimalist aesthetic
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColours.surface,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColours.glassBorder, width: 1.0),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                style: const TextStyle(
                  color: AppColours.textPrimary,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Search topics, terms, or tags...',
                  hintStyle: const TextStyle(
                    color: AppColours.textMuted,
                    fontSize: 15,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColours.textSecondary,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear_rounded,
                            color: AppColours.textSecondary,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Dynamic State Builder Section
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return Center(
                    child: SearchInitialCard(),
                  );
                }

                if (state is SearchLoading) {
                  return const Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.5,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColours.electricBlue),
                        backgroundColor: AppColours.surfaceSecondary,
                      ),
                    ),
                  );
                }

                if (state is SearchLoaded) {
                  final topics = state.topics;

                  if (topics.isEmpty) {
                    return SearchTopicLoadedList(searchController: _searchController);
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    itemCount: topics.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      return LibraryTopicCard(
                        topic: topic,
                        onTap: () {
                          // Navigate to individual topic detail views
                        },
                      );
                    },
                  );
                }

                if (state is SearchError) {
                  final message = state.message;
                  return SearchErrorPage(msg: message,);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
