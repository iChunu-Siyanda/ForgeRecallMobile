  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/topics/domain/entities/create_topic_params.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_event.dart';

void addTopic(BuildContext context, String projectId) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          // This padding ensures the bottom sheet moves up when the keyboard appears
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content tightly
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create New Topic',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // Title Input
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Topic Title',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              
              // Content Input
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Topic Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    final content = contentController.text.trim();

                    if (title.isNotEmpty && content.isNotEmpty) {
                      // 1. Pack the data into your Params object
                      final params = CreateTopicParams(title, projectId, content);

                      // 2. Dispatch the event to your BLoC
                      // (Assuming your event is called CreateTopic)
                      context.read<TopicBloc>().add(CreateTopic(params));

                      // 3. Close the bottom sheet
                      Navigator.pop(bottomSheetContext);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Topic', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }