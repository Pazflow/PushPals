import 'package:flutter/material.dart';

class ChallengeAktivCardWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String fallbackText;
  final String timeLimit;
  final String mode;

  const ChallengeAktivCardWidget({
    super.key,
    this.title = 'Übung',
    this.imagePath = '../assets/images/IT_Nerd.png',
    this.fallbackText = 'Keine Bilder verfügbar',
    this.timeLimit = '24h',
    this.mode = 'Standard',
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF06101F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF06101F),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  imagePath.isEmpty
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image_not_supported,
                            color: Colors.white54,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            fallbackText,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          height: 120,
                          width: double.infinity,
                        ),
                      ),
            ),
            const SizedBox(height: 16),
            Text(
              'Time Limit: $timeLimit',
              style: const TextStyle(color: Colors.white70),
            ),
            Text('Mode: $mode', style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
