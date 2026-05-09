import 'package:flutter/material.dart';
import 'package:forge_recall/features/profile/presentation/widgets/profile_card.dart';
import 'package:forge_recall/features/profile/presentation/widgets/profile_header.dart';
import 'package:forge_recall/features/profile/presentation/widgets/profile_performance_tile.dart';
import 'package:forge_recall/features/profile/presentation/widgets/settings_section.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // POFILE HEADER
              const ProfileHeader(),
              const SizedBox(height: 30),

              // PROFILE CARD
              const ProfileCard(),
              const SizedBox(height: 28),

              // PERFORMANCE OVERVIEW
              const Text(
                'PERFORMANCE OVERVIEW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 18),

              Row(
                children: const [
                  Expanded(
                    child: PerformanceTile(
                      title: 'Recall Stability',
                      value: '81%',
                      accent: Color(0xFF4D8DFF),
                      icon: Icons.psychology_rounded,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: PerformanceTile(
                      title: 'Mental Endurance',
                      value: 'HIGH',
                      accent: Color(0xFFFF7A00),
                      icon: Icons.bolt_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // SETTINGS SECTION
              const SettingsSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
