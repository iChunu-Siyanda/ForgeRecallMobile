import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/dashboard/presentation/widgets/section_title.dart';
import 'package:forge_recall/features/today/presentation/bloc/today_bloc.dart';
import 'package:forge_recall/features/today/presentation/bloc/today_state.dart';
import 'package:forge_recall/features/today/presentation/widgets/due_review_list.dart';
import 'package:forge_recall/features/today/presentation/widgets/recommeded_topic_list.dart';
import 'package:forge_recall/features/today/presentation/widgets/resume_learning_card.dart';
import 'package:forge_recall/features/today/presentation/widgets/today_hero_card.dart';
import 'package:forge_recall/features/today/presentation/widgets/today_progress_card.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});
  void _topics(TopicEntity topic) => topic.content;

  @override
  Widget build(BuildContext context) {
    final List<TopicEntity> topics = [];
    final progress = 0.5;
    
    return Scaffold(
      backgroundColor: AppColours.background,
      appBar: AppBar(
        backgroundColor: AppColours.background,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => MainNavigation.openDrawer(context),
          icon: const Icon(
            Icons.menu,
            color: AppColours.textPrimary,
          ),
        ),
        title: const Text(
          'Today',
          style: TextStyle(
            color: AppColours.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: BlocBuilder<TodayBloc,TodayState>(
        builder: (context, state){
          if (state is TodayLoading) {
            return Center(child: CircularProgressIndicator(),);
          }

          if(state is TodayLoaded){
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              children: [
                TodayHeroCard(),
                SizedBox(height: 28),
                
                SectionTitle(title: 'Continue Studying'),
                SizedBox(height: 12),
                ResumeLearningCard(topic: null,),
                SizedBox(height: 28),
                
                SectionTitle(title: 'Due for Review'),
                SizedBox(height: 12),
                DueReviewList(topics: topics, onTopicTap: _topics),
                SizedBox(height: 28),
                
                SectionTitle(title: 'Recommended For You'),
                SizedBox(height: 12),
                RecommendedTopicsList(topics: topics, onTopicTap: _topics),
                SizedBox(height: 28),
                
                SectionTitle(title: "Today's Progress"),
                SizedBox(height: 12),
                TodayProgressCard(progress: progress),
                SizedBox(height: 32),
              ],
            ); 
          }

          if (state is TodayError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: AppColours.crimson, fontSize: 30),
              ),
            );
          }

          return SizedBox.shrink();
        }
      ),
    );
  }
}
