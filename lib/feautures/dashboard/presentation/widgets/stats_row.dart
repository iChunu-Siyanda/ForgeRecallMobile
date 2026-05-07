import 'package:flutter/material.dart';
import 'package:forge_recall/feautures/dashboard/presentation/widgets/stat_title.dart';


class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [

        Expanded(
          child: StatTile(
            value: "17",
            label: "Streak",
          ),
        ),

        SizedBox(width: 14),

        Expanded(
          child: StatTile(
            value: "92%",
            label: "Mastery",
          ),
        ),

        SizedBox(width: 14),

        Expanded(
          child: StatTile(
            value: "4h",
            label: "Focus",
          ),
        ),
      ],
    );
  }
}