import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/dashboard/presentation/widgets/section_title.dart';
import 'package:forge_recall/features/today/presentation/widgets/continue_studying_placeholder.dart';
import 'package:forge_recall/features/today/presentation/widgets/progress_card.dart';
import 'package:forge_recall/features/today/presentation/widgets/today_hero_card.dart';
import 'package:forge_recall/features/today/presentation/widgets/topic_placeholder_card.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      appBar: AppBar(
        title: const Text('Today'),
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
        children: const [
          TodayHeroCard(),

          SizedBox(height: 28),
          SectionTitle(title: 'Continue Studying'),

          SizedBox(height: 16),
          ContinueStudyingPlaceholder(),

          SizedBox(height: 32),
          SectionTitle(title: 'Due for Review'),

          SizedBox(height: 16),
          TopicPlaceholderCard(),

          SizedBox(height: 12),
          TopicPlaceholderCard(),

          SizedBox(height: 32),
          SectionTitle(title: 'Recommended For You'),

          SizedBox(height: 16),
          TopicPlaceholderCard(),

          SizedBox(height: 12),
          TopicPlaceholderCard(),

          SizedBox(height: 32),
          SectionTitle(title: "Today's Progress",),

          SizedBox(height: 16),
          ProgressCard(),

          SizedBox(height: 32),
        ],
      ),
    );
  }
}
