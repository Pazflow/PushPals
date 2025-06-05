import 'package:flutter/material.dart';

class FriendTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final String imagePath;
  final Color? backgroundcolor;
  final VoidCallback onDelete;
  

  const FriendTile({
    super.key,
    required this.name,
    required this.subtitle,
    required this.imagePath,
    this.backgroundcolor = const Color(0xFF2E2E2E),
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
  onPressed: onDelete,
  icon: const Icon(Icons.delete),
  color: Colors.white70,
  hoverColor: Colors.red.withOpacity(0.2),
  splashColor: Colors.red.withOpacity(0.3),
  highlightColor: Colors.red.withOpacity(0.4),
),

          ],
        ),
      ),
    );
  }
}
