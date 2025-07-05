import 'package:flutter/material.dart';

enum ChallengeStatus { pending, accepted, completed, failed }

extension ChallengeStatusExtension on ChallengeStatus {
  String get text {
    switch (this) {
      case ChallengeStatus.pending:
        return 'Ausstehend';
      case ChallengeStatus.accepted:
        return 'Angenommen';
      case ChallengeStatus.completed:
        return 'Erledigt';
      case ChallengeStatus.failed:
        return 'wurde Abgelehnt';
    }
  }

  Color get color {
    switch (this) {
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
}

ChallengeStatus convertStatusStringToEnum(String status) {
  switch (status) {
    case 'pending':
      return ChallengeStatus.pending;
    case 'accepted':
      return ChallengeStatus.accepted;
    case 'completed':
      return ChallengeStatus.completed;
    case 'failed':
      return ChallengeStatus.failed;
    default:
      return ChallengeStatus.pending;
  }
}
