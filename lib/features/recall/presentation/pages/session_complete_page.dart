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
        ? 0 : (((easyCount + (partialCount * 0.5))/totalQuestions) *100).round();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              const Icon(
                Icons.emoji_events,
                size: 100,
              ),

              const SizedBox(height: 24),

              Text(
                'Session Complete',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 12),

              Text(
                'Great work. Your recall session is finished.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 40),

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

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Review Again',),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    context.go('/projects');
                  },
                  child: const Text('Back To Projects',),
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