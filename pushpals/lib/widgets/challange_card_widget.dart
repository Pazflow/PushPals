import 'package:flutter/material.dart';
import 'package:pushpals/widgets/challenge_status.dart';

class ChallengeCard extends StatelessWidget {
  final String titleText;
  final String challengeText;
  final String imagePath;
  final ChallengeStatus status;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const ChallengeCard({
    super.key,
    required this.titleText,
    required this.challengeText,
    required this.imagePath,
    required this.status,
    this.onAccept,
    this.onDecline,
  });

  Color getStatusColor(ChallengeStatus status) {
    switch (status) {
      case ChallengeStatus.pending:
        return Colors.orange;
      case ChallengeStatus.accepted:
        return Colors.blue;
      case ChallengeStatus.completed:
        return Colors.green;
      case ChallengeStatus.failed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(ChallengeStatus status) {
    switch (status) {
      case ChallengeStatus.pending:
        return 'Status: Ausstehend';
      case ChallengeStatus.accepted:
        return 'Status: Angenommen';
      case ChallengeStatus.completed:
        return 'Status: Erfüllt';
      case ChallengeStatus.failed:
        return 'Status: Fehlgeschlagen';
      default:
        return 'Status: Unbekannt';
    }
  }

  ImageProvider getImageProvider(String path) {
    return path.startsWith('http')
        ? NetworkImage(path)
        : AssetImage(path) as ImageProvider;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: getStatusColor(status),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: getImageProvider(imagePath),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    titleText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    challengeText,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getStatusText(status),
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  if (status == ChallengeStatus.pending) // Nur wenn pending
                    Row(
                      children: [
                        IconButton(
                          onPressed: onAccept,
                          icon: const Icon(Icons.check, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: onDecline,
                          icon: const Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
