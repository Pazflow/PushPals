import 'package:flutter/material.dart';

class ChallengeAktivCardWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isNetworkImage;
  final String fallbackText;
  final String timeLimit;
  final String mode;
  final int repetitions;

  const ChallengeAktivCardWidget({
    super.key,
    required this.title,
    required this.imagePath,
    this.isNetworkImage = false,
    required this.fallbackText,
    required this.timeLimit,
    required this.mode,
    required this.repetitions,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath.isNotEmpty;

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
                  hasImage
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            isNetworkImage
                                ? Image.network(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: double.infinity,
                                )
                                : Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: double.infinity,
                                ),
                      )
                      : Column(
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
                      ),
            ),
            const SizedBox(height: 16),
            Text(
              'Time Limit: $timeLimit',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Wiederholungen: $repetitions',
              style: const TextStyle(color: Colors.white70),
            ),
            Text('Mode: $mode', style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
