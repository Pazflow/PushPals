import 'package:flutter/material.dart';
import 'package:pushpals/models/friend_model.dart'; // Pfad anpassen!

class FriendTile extends StatelessWidget {
  final Friend friend;
  final VoidCallback onDelete;

  const FriendTile({
    super.key,
    required this.friend,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final publicUrl = friend.profileImageUrl;

    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF2E2E2E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: ClipOval(
                child: publicUrl.isNotEmpty
                    ? Image.network(
                        publicUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // ➡️ Zeige Standardbild bei Fehler
                          return Image.asset(
                            'assets/images/IT_Nerd.png',
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/IT_Nerd.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    friend.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Friend',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
