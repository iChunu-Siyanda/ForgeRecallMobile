import 'package:flutter/material.dart';
import 'package:forge_recall/features/profile/presentation/widgets/profile_settings_tile.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SETTINGS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),

        const SizedBox(height: 18),

        ProfileSettingsTile(
          title: 'Theme',
          subtitle: 'Dark Mode Enabled',
          icon: Icons.dark_mode_rounded,
          accent: const Color(0xFF4D8DFF),
          onTap: () {},
        ),

        const SizedBox(height: 14),

        ProfileSettingsTile(
          title: 'Notifications',
          subtitle: 'Recall reminders active',
          icon: Icons.notifications_active_rounded,
          accent: const Color(0xFF2ECC71),
          onTap: () {},
        ),

        const SizedBox(height: 14),

        ProfileSettingsTile(
          title: 'AI Settings',
          subtitle: 'Manage AI generation preferences',
          icon: Icons.auto_awesome_rounded,
          accent: const Color(0xFFFF7A00),
          onTap: () {},
        ),

        const SizedBox(height: 14),

        ProfileSettingsTile(
          title: 'Export Data',
          subtitle: 'Backup mastery data',
          icon: Icons.ios_share_rounded,
          accent: const Color(0xFF9B59B6),
          onTap: () {},
        ),

        const SizedBox(height: 14),

        ProfileSettingsTile(
          title: 'Logout',
          subtitle: 'Exit your account',
          icon: Icons.logout_rounded,
          accent: const Color(0xFFFF4D5A),
          onTap: () {},
        ),
      ],
    );
  }
}
