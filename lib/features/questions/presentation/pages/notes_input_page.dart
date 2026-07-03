import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
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
    
    context.push(AppRoutes.previewQuestions, extra: QuestionPreviewParams(topic: widget.topic, note: notes),);

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
      backgroundColor: AppColours.background,
      appBar: AppBar(
        backgroundColor: AppColours.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(color: AppColours.glassBorder, width: 1),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColours.textPrimary, size: 20),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          widget.topic.title,
          style: const TextStyle(
            color: AppColours.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Informational Instructions Panel
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColours.surfaceSecondary,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColours.glassBorder),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        color: AppColours.electricBlue,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Paste Your Study Notes',
                              style: TextStyle(
                                color: AppColours.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Paste textbook notes, class notes, summaries, or any study material.',
                              style: TextStyle(
                                color: AppColours.textSecondary,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Canvas Area for Text Input
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColours.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColours.glassBorder, width: 1.5),
                  ),
                  child: TextField(
                    controller: _notesController,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(
                      color: AppColours.textPrimary,
                      fontSize: 15,
                      height: 1.4,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Example:\n\nCellular respiration is the process by which cells convert glucose into ATP...',
                      hintStyle: const TextStyle(color: AppColours.textMuted, fontSize: 14),
                      contentPadding: const EdgeInsets.all(18),
                      border: InputBorder.none,
                      // Re-applying borders contextually cleanly onto the outer decoration layout container
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColours.electricBlue, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Text Metadata Trackers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Words: $wordCount',
                      style: const TextStyle(
                        color: AppColours.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${_notesController.text.length} characters',
                      style: const TextStyle(
                        color: AppColours.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Magic AI Generation Button
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColours.geminiGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColours.geminiBlue.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: _generateQuestions,
                  icon: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
                  label: const Text(
                    'Generate Questions',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: -0.1,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
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
