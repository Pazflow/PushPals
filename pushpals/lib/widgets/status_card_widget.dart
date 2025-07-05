import 'package:flutter/material.dart';
import 'package:pushpals/enums/enum_challenge_status.dart';

class StatusDisplayWidget extends StatelessWidget {
  final String label;
  final ChallengeStatus status;

  const StatusDisplayWidget({
    super.key,
    this.label = 'Status:',
    this.status = ChallengeStatus.pending,
  });


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
              status.text,
              style: TextStyle(
                color: status.color,
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
