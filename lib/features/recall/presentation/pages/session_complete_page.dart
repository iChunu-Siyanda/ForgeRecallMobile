import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionCompletePage extends StatelessWidget {
  final int totalQuestions;
  final int easyCount;
  final int partialCount;
  final int forgotCount;

  const SessionCompletePage({
    super.key,
    required this.totalQuestions,
    required this.easyCount,
    required this.partialCount,
    required this.forgotCount,
  });

  @override
  Widget build(BuildContext context) {
    final accuracy = totalQuestions == 0
        ? 0
        : (((easyCount + (partialCount * 0.5)) /
                    totalQuestions) *
                100)
            .round();

    final performance = switch (accuracy) {
      >= 90 => 'Mastery',
      >= 75 => 'Strong Recall',
      >= 60 => 'Developing',
      _ => 'Needs Reinforcement',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Complete'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              const SizedBox(height: 16),

              const Icon(
                Icons.emoji_events,
                size: 96,
              ),

              const SizedBox(height: 20),

              Text(
                '$accuracy%',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge,
              ),

              const SizedBox(height: 8),

              Text(
                performance,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
              ),

              const SizedBox(height: 12),

              Text(
                'Active recall session completed successfully.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge,
              ),

              const SizedBox(height: 32),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _StatRow(
                        label: 'Questions Reviewed',
                        value: '$totalQuestions',
                      ),

                      const Divider(),

                      _StatRow(
                        label: '😎 Easy',
                        value: '$easyCount',
                      ),

                      _StatRow(
                        label: '🤔 Partial',
                        value: '$partialCount',
                      ),

                      _StatRow(
                        label: '😵 Forgot',
                        value: '$forgotCount',
                      ),

                      const Divider(),

                      _StatRow(
                        label: 'Accuracy',
                        value: '$accuracy%',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.psychology,
                        size: 40,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        accuracy >= 75
                            ? 'Your memory traces are strengthening. Continue reviewing on schedule.'
                            : 'Several concepts need reinforcement. A follow-up review is recommended.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'Review Again',
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.go('/projects');
                  },
                  icon: const Icon(Icons.home),
                  label: const Text(
                    'Back To Projects',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(label),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}