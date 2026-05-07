import 'package:flutter/material.dart';

class ProjectButton extends StatelessWidget {
  const ProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF4D8DFF), Color(0xFF356DDA)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4D8DFF).withValues(alpha: 0.35),
              blurRadius: 25,
              spreadRadius: -8,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add_rounded, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'CREATE PROJECT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
