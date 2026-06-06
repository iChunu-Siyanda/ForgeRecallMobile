import 'package:flutter/material.dart';

class TopicStatsCard extends StatelessWidget {
  const TopicStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: const [
          ListTile(
            title: Text('Questions Created'),
            trailing: Text('0'),
          ),
          Divider(),
          ListTile(
            title: Text('Mastery'),
            trailing: Text('0%'),
          ),
        ],
      ),
    );
  }
}