import 'package:flutter/material.dart';
import 'package:forge_recall/feautures/recall/presentation/widgets/recall_mode_card.dart';
import 'package:forge_recall/theme/app_colours.dart';

class RecallModes extends StatelessWidget {
  const RecallModes({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RecallModeCard(
          title: "STANDARD DRILL",
          subtitle: "Active recall repetition training",
          icon: Icons.psychology_alt_rounded,
          accent: AppColours.electricBlue,
          stats: "42 Questions Due",
        ),

        const SizedBox(height: 16),

        RecallModeCard(
          title: "PRESSURE RECALL",
          subtitle: "Timed rapid-response memory combat",
          icon: Icons.timer_rounded,
          accent: AppColours.emberOrange,
          stats: "5s Response Window",
        ),

        const SizedBox(height: 16),

        RecallModeCard(
          title: "WEAKNESS REPAIR",
          subtitle: "Target unstable memory regions",
          icon: Icons.warning_amber_rounded,
          accent: AppColours.crimson,
          stats: "12 Critical Failures",
        ),

        const SizedBox(height: 16),

        RecallModeCard(
          title: "EXAM SIMULATION",
          subtitle: "High-pressure cognitive endurance",
          icon: Icons.gpp_good_rounded,
          accent: AppColours.emerald,
          stats: "90 Minute Simulation",
        ),
      ],
    );
  }
}
