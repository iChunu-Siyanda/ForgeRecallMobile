import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/core/widgets/bloc_error_widget.dart';
import 'package:forge_recall/features/analytics/domain/entities/analytics_time_frame.dart';
import 'package:forge_recall/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:forge_recall/features/analytics/presentation/bloc/analytics_event.dart';
import 'package:forge_recall/features/analytics/presentation/bloc/analytics_state.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/hero_chat_card.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/kpi_grid.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/needs_attention_carousel.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/project_mastery_list.dart';
import 'package:forge_recall/features/analytics/presentation/widgets/time_frame_picker.dart';

class AnalyticsPage extends StatefulWidget {

  const AnalyticsPage({
    super.key,
  });

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final int _selectedTimeframe = 0; // 0: 7 Days, 1: 30 Days, 2: All Time
  bool _showLineGraph = true; // Toggle between Accuracy (Line) & Volume (Bar)

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColours.background,
      appBar: AppBar(
        backgroundColor: AppColours.background,
        elevation: 0,
        //scaffoldWillScaffold: false,
        title: const Text(
          'Analytics',
          style: TextStyle(
            color: AppColours.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          onPressed: () => MainNavigation.openDrawer(context),
          icon: const Icon(
            Icons.menu,
            color: AppColours.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune_rounded,
              color: AppColours.textSecondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: BlocBuilder<AnalyticsBloc,AnalyticsState>(
          builder: (context, state) {
            if (state is AnalyticsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          
            if (state is AnalyticsLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeframe Segmented Control
                  TimeframePicker(
                    selectedIndex: _selectedTimeframe,
                    onChanged: (index){
                      context.read<AnalyticsBloc>().add(
                        ChangeAnalyticsTimeframe(AnalyticsTimeframe.values[index]),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
              
                  // Hero Chart Card (Line/Bar Hybrid)
                  HeroChartCard(
                    sessions: state.sessions,
                    isLineGraph: _showLineGraph,
                    onToggleGraph: () => setState(() => _showLineGraph = !_showLineGraph),
                  ),
                  const SizedBox(height: 20),
              
                  // 2x2 Key Metric Grid
                  KpiGrid(
                    dueTopicsCount: state.totalDueTopics,
                    averageMastery: state.avgMastery,
                    avgDifficulty: state.avgDifficulty,
                    totalQuestions: state.totalQuestions,
                  ),
                  const SizedBox(height: 24),
              
                  // Project Mastery Section
                  const Text(
                    'Project Mastery',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColours.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ProjectMasteryList(projectCards: state.projectCards),
                  const SizedBox(height: 24),
              
                  // Topics Needing Attention (Horizontal Swipe)
                  if (state.needsAttentionTopics.isNotEmpty) ...[
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Needs Attention',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColours.textPrimary,
                          ),
                        ),
                        Text(
                          'Low Mastery',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColours.crimson,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    NeedsAttentionCarousel(topics: state.needsAttentionTopics),
                    const SizedBox(height: 24),
                  ],
                ],
              );
            }

            if (state is AnalyticsError){
              return BlocErrorWidget(message: state.message);
            }

            return SizedBox.shrink();
          }
        ),
      ),
    );
  }
}
