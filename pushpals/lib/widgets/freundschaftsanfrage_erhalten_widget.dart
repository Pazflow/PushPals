import 'package:flutter/material.dart';

class FriendRequestWidget extends StatelessWidget {
  final String name;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const FriendRequestWidget({
    super.key,
    required this.name,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: const Color(0xFF424242),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'möchte mit dir befreundet sein',
          style: TextStyle(color: Colors.white70),
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: onAccept,
              tooltip: 'Annehmen',
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.redAccent),
              onPressed: onDecline,
              tooltip: 'Ablehnen',
            ),
          ],
        ),
      ),
    );
  }
}
