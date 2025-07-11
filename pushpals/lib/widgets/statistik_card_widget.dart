import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/profile_setup_model.dart';


class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final profileModel = Provider.of<ProfileSetupModel>(context);


    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF06101F),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  value: profileModel.level.toString(),
                  label: 'Level',
                ),
                _buildStat(
                  icon: '🏋️‍♂️',
                  value: profileModel.challengesCompleted.toString(),
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
    required dynamic icon,
    required String value,
    required String label,
  }) {
    Widget iconWidget;

    if (icon is IconData) {
      iconWidget = Icon(icon, color: Colors.white, size: 24);
    } else if (icon is String) {
      iconWidget = Text(icon, style: const TextStyle(fontSize: 24));
    } else {
      iconWidget = const SizedBox.shrink();
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
