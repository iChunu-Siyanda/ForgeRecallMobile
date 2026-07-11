import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:go_router/go_router.dart';

class MethodSheet extends StatelessWidget {
  const MethodSheet({
    super.key,
    required this.topic,
  });

  final TopicEntity topic;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Input Method',
              style: TextStyle(
                color: AppColours.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 16),
            
            // Option 1: Active Type Notes
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: AppColours.surfaceSecondary.withValues(alpha:0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.edit_note_rounded, color: AppColours.electricBlue),
                title: Text(
                  'Type Notes',
                  style: TextStyle(color: AppColours.textPrimary, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Paste study material manually',
                  style: TextStyle(color: AppColours.textSecondary, fontSize: 13),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onTap: () {
                  Navigator.pop(context);
                  context.push(AppRoutes.notesInput, extra: topic);
                },
              ),
            ),
    
            // Option 2: Disabled Image Upload
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColours.glassBorder.withValues(alpha: .6)),
              ),
              child: ListTile(
                leading: const Icon(Icons.image_outlined, color: AppColours.textMuted),
                title: Text(
                  'Upload Image',
                  style: TextStyle(color: AppColours.textMuted, fontWeight: FontWeight.w500),
                ),
                subtitle: const Text(
                  'Coming Soon',
                  style: TextStyle(color: AppColours.amber, fontWeight: FontWeight.w500, fontSize: 12),
                ),
                enabled: false,
              ),
            ),
    
            // Option 3: Disabled PDF Upload
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColours.glassBorder.withValues(alpha: .6)),
              ),
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf_outlined, color: AppColours.textMuted),
                title: Text(
                  'Upload PDF',
                  style: TextStyle(color: AppColours.textMuted, fontWeight: FontWeight.w500),
                ),
                subtitle: const Text(
                  'Coming Soon',
                  style: TextStyle(color: AppColours.amber, fontWeight: FontWeight.w500, fontSize: 12),
                ),
                enabled: false,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
