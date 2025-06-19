import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Einstellungen',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSwitchTile('Benachrichtigungen', true),
            _buildSwitchTile('Sound', true),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.volume_mute, color: Colors.white),
                Expanded(
                  child: Slider(
                    value: 0.5,
                    onChanged: (_) {},
                    activeColor: const Color(0xFF0084FF),
                    inactiveColor: const Color(0xFF3B0202),
                  ),
                ),
                const Icon(Icons.volume_up, color: Colors.white),
              ],
            ),
            const Divider(color: Colors.white24, height: 32),
            _buildSettingsRow(Icons.fitness_center, 'Übungseinstellungen'),
            _buildSettingsRow(Icons.emoji_events, 'Alle Achievements'),
            const Divider(color: Colors.white24, height: 32),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Ausloggen',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String label, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        Switch(value: value, onChanged: (_) {}, activeColor: Colors.blue),
      ],
    );
  }

  Widget _buildSettingsRow(IconData icon, String label) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.blue),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 16,
      ),
      onTap: () {},
    );
  }
}
