import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final int level;
  final int challenges;

  const StatsCard({
    super.key,
    required this.level,
    required this.challenges,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Titel linksbündig
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
              _buildStat(icon: '📈', value: level.toString(), label: 'Level'),
              _buildStat(icon: '🏋️‍♂️', value: challenges.toString(), label: 'Challenges'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat({
    required String icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20)),
        Text(label, style: const TextStyle(color: Colors.white54)),
      ],
    );
  }
}
