import 'package:flutter/material.dart';

enum ChallengeStatus { pending, accepted, completed, failed }

class StatusDisplayWidget extends StatelessWidget {
  final String label;
  final ChallengeStatus status;

  const StatusDisplayWidget({
    super.key,
    this.label = 'Status:',
    this.status = ChallengeStatus.pending,
  });

  Color getStatusColor(ChallengeStatus status) {
    switch (status) {
      case ChallengeStatus.pending:
        return Colors.yellow;
      case ChallengeStatus.accepted:
        return Colors.blue;
      case ChallengeStatus.completed:
        return Colors.green;
      case ChallengeStatus.failed:
        return Colors.red;
    }
  }

  String getStatusText(ChallengeStatus status) {
    switch (status) {
      case ChallengeStatus.pending:
        return 'Ausstehend';
      case ChallengeStatus.accepted:
        return 'Angenommen';
      case ChallengeStatus.completed:
        return 'Erledigt';
      case ChallengeStatus.failed:
        return 'Fehlgeschlagen';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF06101F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              getStatusText(status),
              style: TextStyle(
                color: getStatusColor(status),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
