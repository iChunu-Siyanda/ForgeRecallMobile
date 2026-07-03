import 'package:flutter/material.dart';
import 'package:forge_recall/core/theme/app_colours.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectsBloc/project_bloc.dart';
import 'package:forge_recall/features/projects/presentation/widgets/create_project_modal.dart';

class FabCreateProjectModal extends StatelessWidget {
  final ProjectBloc projectBloc;
  const FabCreateProjectModal({
    super.key,
    required this.projectBloc,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showCreateProjectModal(context, projectBloc),
      elevation: 4,
      highlightElevation: 2,
      // Make the background transparent so the internal gradient shows through cleanly
      backgroundColor: Colors.transparent, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Smooth Material 3 rounding
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: AppColours.geminiGradient, // Your signature blue-purple-pink mix
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 56, minHeight: 56), // Standard FAB sizing
          alignment: Alignment.center,
          child: const Icon(
            Icons.add_rounded, 
            color: Colors.white, 
            size: 26,
          ),
        ),
      ),
    );
  }
}

void _showCreateProjectModal(
  BuildContext context,
  ProjectBloc projectBloc,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.45,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return CreateProjectModal(
            projectBloc: projectBloc,
          );
        },
      );
    },
  );
}
