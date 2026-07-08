import 'package:flutter/material.dart';

class TopicPlaceholderCard extends StatelessWidget {
  const TopicPlaceholderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.menu_book_outlined),
        ),
        title: const Text('No topics yet'),
        subtitle: const Text('Topics will appear here'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
