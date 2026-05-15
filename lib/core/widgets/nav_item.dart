import 'package:flutter/material.dart';
import 'package:forge_recall/theme/app_colours.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      behavior: HitTestBehavior.opaque,

      child: SizedBox(
        width: 64,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),

              child: Icon(
                icon,
                color: isSelected ? AppColours.electricBlue : Colors.white38,
                size: isSelected ? 28 : 24,
              ),
            ),

            const SizedBox(height: 6),

            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),

              style: TextStyle(
                color: isSelected ? AppColours.electricBlue : Colors.white38,

                fontSize: isSelected ? 12 : 11,

                fontWeight: FontWeight.w600,

                letterSpacing: 0.5,
              ),

              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
