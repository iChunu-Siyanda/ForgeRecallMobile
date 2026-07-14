import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';

class SearchTopicLoadedList extends StatelessWidget {
  const SearchTopicLoadedList({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
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
                Icons.search_off_rounded,
                size: 40,
                color: AppColours.textMuted,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No matching results',
              style: TextStyle(
                color: AppColours.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "We couldn't find anything matching \"${_searchController.text}\"",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColours.textMuted,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
