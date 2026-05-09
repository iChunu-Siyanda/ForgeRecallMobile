import 'package:flutter/material.dart';
import 'package:forge_recall/features/profile/presentation/widgets/profile_glass_card.dart';
import 'package:forge_recall/features/profile/presentation/widgets/profile_stat_card.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGlassCard(
      child: Column(
        children: [
          Container(
            height: 96,
            width: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF4D8DFF), Color(0xFF356DDA)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4D8DFF).withValues(alpha: 0.4),
                  blurRadius: 30,
                  spreadRadius: -10,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'S',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            'Siyanda',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF4D8DFF).withValues(alpha: 0.12),
            ),
            child: const Text(
              'LEVEL 18 FORGER',
              style: TextStyle(
                color: Color(0xFF4D8DFF),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),

          const SizedBox(height: 28),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Expanded(child: ProfileStatCard(title: 'Streak', value: '17')),
              SizedBox(width: 14),
              Expanded(child: ProfileStatCard(title: 'Sessions', value: '241')),
              SizedBox(width: 14),
              Expanded(child: ProfileStatCard(title: 'Hours', value: '84h')),
            ],
          ),
        ],
      ),
    );
  }
}
