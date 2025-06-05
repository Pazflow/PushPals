import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final int level;
  final int challenges;

  const StatsCard({super.key, required this.level, required this.challenges});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2E2E2E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Titel linksbündig
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Deine Statistik',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(
                  icon: Icons.show_chart,
                  value: level.toString(),
                  label: 'Level',
                ),
                _buildStat(
                  icon: '🏋️‍♂️',
                  value: challenges.toString(),
                  label: 'Challenges',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat({
    required dynamic icon, // <-- dynamic statt String
    required String value,
    required String label,
  }) {
    Widget iconWidget;

    if (icon is IconData) {
      iconWidget = Icon(icon, color: Colors.white, size: 24);
    } else if (icon is String) {
      iconWidget = Text(icon, style: const TextStyle(fontSize: 24));
    } else {
      iconWidget = const SizedBox.shrink(); // Fallback
    }

    return Column(
      children: [
        iconWidget,
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20)),
        Text(label, style: const TextStyle(color: Colors.white54)),
      ],
    );
  }
}
