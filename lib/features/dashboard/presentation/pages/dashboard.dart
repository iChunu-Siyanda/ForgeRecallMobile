import 'package:flutter/material.dart';
import 'package:forge_recall/features/dashboard/presentation/widgets/battle_card.dart';
import 'package:forge_recall/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:forge_recall/features/dashboard/presentation/widgets/forge_score_card.dart';
import 'package:forge_recall/features/dashboard/presentation/widgets/section_title.dart';
import 'package:forge_recall/features/dashboard/presentation/widgets/stats_row.dart';
import 'package:forge_recall/features/dashboard/presentation/widgets/weakness_alert.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const DashboardHeader(),

              const SizedBox(height: 28),

              const ForgeScoreCard(),

              const SizedBox(height: 24),

              const StatsRow(),

              const SizedBox(height: 32),

              const SectionTitle(
                title: "TODAY'S SESSIONS",
              ),

              const SizedBox(height: 16),

              const BattleCard(
                title: "Flutter Development",
                drills: 12,
                duration: "28 min",
                difficulty: "HIGH",
              ),

              const SizedBox(height: 14),

              const BattleCard(
                title: "Calculus",
                drills: 8,
                duration: "18 min",
                difficulty: "MEDIUM",
              ),

              const SizedBox(height: 32),

              const SectionTitle(
                title: "WEAKNESS ALERTS",
              ),

              const SizedBox(height: 16),

              const WeaknessAlertCard(
                topic: "State Management",
                strength: 31,
              ),

              const SizedBox(height: 14),

              const WeaknessAlertCard(
                topic: "Memory Retention",
                strength: 22,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}