import 'package:flutter/material.dart';

class ProjectSectionTitle extends StatelessWidget {
  const ProjectSectionTitle({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'ACTIVE PROJECTS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        Text(
          'View All',
          style: TextStyle(
            color: Color(0xFF4D8DFF),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
