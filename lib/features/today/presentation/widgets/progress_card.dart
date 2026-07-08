import 'package:flutter/material.dart';
import 'package:forge_recall/features/today/presentation/widgets/progress_stat.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Daily Goal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '0%',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(
              value: 0,
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProgressStat(
                  label: 'Topics',
                  value: '0',
                ),
                ProgressStat(
                  label: 'Questions',
                  value: '0',
                ),
                ProgressStat(
                  label: 'Minutes',
                  value: '0',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
