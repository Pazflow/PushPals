import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  final String name;
  final String birthdate;
  final String avatarPath;

  const AvatarCard({
    super.key,
    required this.name,
    required this.birthdate,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ⬅️ volle Breite
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(radius: 32, backgroundImage: AssetImage(avatarPath)),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // ⬅️ nur so hoch wie nötig
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(birthdate, style: const TextStyle(color: Colors.white54)),
            ],
          ),
        ],
      ),
    );
  }
}
