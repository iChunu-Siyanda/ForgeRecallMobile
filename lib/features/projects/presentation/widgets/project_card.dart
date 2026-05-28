import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:forge_recall/features/projects/presentation/widgets/project_stat_tile.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final double mastery;
  final int topics;
  final int due;
  final Color accentColor;

  const ProjectCard({
    super.key,
    required this.title,
    required this.mastery,
    required this.topics,
    required this.due,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final masteryValue = mastery.clamp(0, 100);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.18),
              blurRadius: 40,
              spreadRadius: -8,
              offset: const Offset(0, 24),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.10),
                    Colors.white.withValues(alpha: 0.03),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1.2,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -80,
                    right: -40,
                    child: Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentColor.withValues(alpha: 0.12),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -100,
                    left: -60,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.03),
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// HEADER
                      Row(
                        children: [
                          Container(
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  accentColor,
                                  accentColor.withValues(alpha: 0.65),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      accentColor.withValues(alpha: 0.35),
                                  blurRadius: 22,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.auto_awesome_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),

                          const SizedBox(width: 18),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    _buildMiniChip(
                                      icon: Icons.menu_book_rounded,
                                      label: '$topics Topics',
                                    ),
                                    const SizedBox(width: 10),
                                    _buildMiniChip(
                                      icon: Icons.bolt_rounded,
                                      label: '$due Due',
                                      color: due > 0
                                          ? Colors.orangeAccent
                                          : Colors.greenAccent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color:
                                  Colors.white.withValues(alpha: 0.06),
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      /// MASTERY SECTION
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Mastery Progress',
                            style: TextStyle(
                              color: Color(0xFFB6BED1),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(100),
                              color:
                                  accentColor.withValues(alpha: 0.15),
                              border: Border.all(
                                color: accentColor.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                            ),
                            child: Text(
                              '${masteryValue.toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Stack(
                        children: [
                          Container(
                            height: 14,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(100),
                              color:
                                  Colors.white.withValues(alpha: 0.05),
                            ),
                          ),

                          FractionallySizedBox(
                            widthFactor: masteryValue / 100,
                            child: Container(
                              height: 14,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(100),
                                gradient: LinearGradient(
                                  colors: [
                                    accentColor,
                                    accentColor.withValues(
                                      alpha: 0.65,
                                    ),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withValues(
                                      alpha: 0.45,
                                    ),
                                    blurRadius: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      /// STATS
                      Row(
                        children: [
                          Expanded(
                            child: ProjectStatTile(
                              title: 'Recall',
                              value:
                                  '${(masteryValue * 1.2).round()}%',
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: ProjectStatTile(
                              title: 'Speed',
                              value: '2.8s',
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: ProjectStatTile(
                              title: 'Streak',
                              value: '17',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      /// ACTIONS
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.white.withValues(
                                    alpha: 0.08,
                                  ),
                                ),
                                backgroundColor:
                                    Colors.white.withValues(
                                  alpha: 0.03,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.analytics_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Analytics',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: accentColor,
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Start Drill',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniChip({
    required IconData icon,
    required String label,
    Color color = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
