import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/domain/entities/create_project_params.dart';
import '../bloc/projectsBloc/project_bloc.dart';
import '../bloc/projectsBloc/project_event.dart';

class CreateProjectModal extends StatefulWidget {
  const CreateProjectModal({super.key, required this.projectBloc});

  final ProjectBloc projectBloc;

  @override
  State<CreateProjectModal> createState() =>
      _CreateProjectModalState();
}

class _CreateProjectModalState
    extends State<CreateProjectModal> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _createProject() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.projectBloc.add(
      CreateProjectEvent(
        CreateProjectParams(title: titleController.text.trim(), description: descriptionController.text.trim(),),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              /// Drag Handle
              Center(
                child: Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                "Create Project",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Start building your mastery system.",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 32),

              /// Title Field
              TextFormField(
                controller: titleController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Project title",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                  filled: true,
                  fillColor:
                      const Color(0xFF1E1E1E),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter project title";
                  }

                  if (value.trim().length < 3) {
                    return "Title too short";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Description Field
              TextFormField(
                controller: descriptionController,
                maxLines: 5,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Project description",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                  filled: true,
                  fillColor:
                      const Color(0xFF1E1E1E),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter description";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 32),

              /// Create Button
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepPurple,
                    foregroundColor:
                        Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: _createProject,
                  child: const Text(
                    "Add Project",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w600,
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