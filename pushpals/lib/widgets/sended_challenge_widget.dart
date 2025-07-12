import 'package:flutter/material.dart';
import 'status_card_widget.dart';
import 'aktiv_card_widget.dart';
import 'challenge_aktiv_card_widget.dart';
import 'package:pushpals/enums/enum_challenge_status.dart';

class SendenChallengeWidget extends StatelessWidget {
  final Map<String, dynamic> challengeData;
  final String? gifUrl; // 👈 hinzugefügt

  const SendenChallengeWidget({
    super.key,
    required this.challengeData,
    this.gifUrl, // 👈 hinzugefügt
  });

  @override
  Widget build(BuildContext context) {
    final statusString = challengeData['challenge_status'] ?? 'pending';
    final ChallengeStatus statusEnum = convertStatusStringToEnum(statusString);

    return Column(
      children: [
        StatusDisplayWidget(status: statusEnum),
        AktivCardWidget(
          profileName: challengeData['exercise'] ?? 'Unbekannt',
          subtitle:
              'Hat ${challengeData['receiver']['username']} herausgefordert',
          imagePath:
              (challengeData['receiver']['profile_image_url'] != null &&
                      (challengeData['receiver']['profile_image_url'] as String)
                          .isNotEmpty)
                  ? challengeData['receiver']['profile_image_url']
                  : 'assets/images/IT_Nerd.png',
          isNetworkImage:
              (challengeData['receiver']['profile_image_url'] != null &&
                  (challengeData['receiver']['profile_image_url'] as String)
                      .isNotEmpty),
        ),
        ChallengeAktivCardWidget(
          title: challengeData['exercise'] ?? 'Übung',
          fallbackText: 'Keine Bilder verfügbar',
          timeLimit: challengeData['time_limit'] ?? 'unbegrenzt',
          mode: 'Standard',
          repetitions: challengeData['repetitions'] ?? 0,
        ),
      ],
    );
  }
}
