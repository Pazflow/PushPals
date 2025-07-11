import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  final int rank;
  final String name;
  final int level;
  final int challenge;
  final String avatarUrl;
  final Color color;
  final dynamic icon; // <- erlaubt IconData oder String

  const PlayerTile({
    super.key,
    required this.rank,
    required this.name,
    required this.level,
    required this.challenge,
    required this.avatarUrl,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ImageProvider avatarImage =
        avatarUrl.startsWith('http')
            ? NetworkImage(avatarUrl)
            : AssetImage(avatarUrl) as ImageProvider;

    Widget iconWidget;
    if (icon is IconData) {
      iconWidget = Icon(icon, color: Colors.white, size: 20);
    } else if (icon is String) {
      iconWidget = Text(icon, style: const TextStyle(fontSize: 20));
    } else {
      iconWidget = const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          iconWidget,
          const SizedBox(width: 8),
          CircleAvatar(backgroundImage: avatarImage, radius: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Text('Level $level', style: const TextStyle(color: Colors.white70)),
          const SizedBox(width: 12),
          Text(':', style: const TextStyle(color: Colors.white70)),
          const SizedBox(width: 12),
          Text('Duelle $challenge', style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
