import 'package:flutter/material.dart';

class ContinueStudyingPlaceholder extends StatelessWidget {
  const ContinueStudyingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.play_arrow),
        ),
        title: const Text('No active study session'),
        subtitle: const Text('Start studying to continue here'),
        trailing: FilledButton(
          onPressed: null,
          child: const Text('Start'),
        ),
      ),
    );
  }
}
