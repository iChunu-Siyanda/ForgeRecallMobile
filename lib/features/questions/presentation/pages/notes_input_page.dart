
import 'package:flutter/material.dart';
import 'package:forge_recall/features/questions/domain/entities/question_preview_params.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:go_router/go_router.dart';

class NotesInputPage extends StatefulWidget {
  final TopicEntity topic;

  const NotesInputPage({
    super.key,
    required this.topic,
  });

  @override
  State<NotesInputPage> createState() => _NotesInputPageState();
}

class _NotesInputPageState extends State<NotesInputPage> {
  //TODO:
  //Add an autosave indicator later
  final TextEditingController _notesController =
      TextEditingController();

  int get wordCount { 
    final text = _notesController.text.trim();
    if (text.isEmpty) return 0;

    return text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  @override
  void initState() {
    super.initState();

    _notesController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _generateQuestions() {
    final notes = _notesController.text.trim();

    if (notes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter some study notes first.',
          ),
        ),
      );

      return;
    }
    
    context.go('/questionsPreviewPage', extra: QuestionPreviewParams(topic: widget.topic, note: notes),);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Question generation coming next.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){context.go('/topicsKnowledgePage', extra: widget.topic,);},),
        title: Text(widget.topic.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paste Your Study Notes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Paste textbook notes, class notes, summaries, or any study material.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: TextField(
                controller: _notesController,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical:TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText:'Example:\n\nCellular respiration is the process by which cells convert glucose into ATP...',
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text('Words: $wordCount',),

                Text('${_notesController.text.length} characters',),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: _generateQuestions,
                icon: const Icon(Icons.auto_awesome,),
                label: const Text('Generate Questions',),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
