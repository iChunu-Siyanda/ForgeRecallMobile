import 'package:flutter/material.dart';

class CustomQuestionsCard extends StatelessWidget {
  final VoidCallback onAddQuestion;

  const CustomQuestionsCard({
    super.key,
    required this.onAddQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.quiz_outlined),
        title: const Text('Custom Questions'),
        subtitle: const Text(
          'Create your own recall questions without uploading material.',
        ),
        trailing: FilledButton(
          onPressed: onAddQuestion,
          child: const Text('Add'),
        ),
      ),
    );
  }
}