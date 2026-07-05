import 'package:flutter/material.dart';

class ContinueStudyingCard extends StatelessWidget {
  const ContinueStudyingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(
              Icons.play_circle_fill,
              size: 48,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Continue Studying',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Pick up where you left off.',
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: null,
              child: const Text('Resume'),
            )
          ],
        ),
      ),
    );
  }
}
