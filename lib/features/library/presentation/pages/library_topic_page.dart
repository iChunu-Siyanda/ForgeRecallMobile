import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/shared/entites/topic_filter.dart';
import 'package:forge_recall/features/library/presentation/bloc/library_bloc.dart';
import 'package:forge_recall/features/library/presentation/bloc/library_state.dart';
import 'package:forge_recall/features/library/presentation/widgets/library_topic_card.dart';

class LibraryTopicsPage extends StatelessWidget {
  final String title;
  final TopicFilter filter;

  const LibraryTopicsPage({
    super.key,
    required this.title,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<LibraryBloc,LibraryState>(
        builder: (context, state) {
          if(state is LibraryLoading) {
            return CircularProgressIndicator();
          }

          if(state is LibraryLoaded) {
            final topics = state.topics;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: topics.length, 
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final topic = topics[index];
            
                return LibraryTopicCard(topic: topic);
              },
            );
          }

          if (state is LibraryError) {
            return Center(
              child: Text(state.message),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
