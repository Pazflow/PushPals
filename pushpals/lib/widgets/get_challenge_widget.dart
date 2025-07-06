import 'package:flutter/material.dart';

import 'status_card_widget.dart';
import 'aktiv_card_widget.dart';
import 'challenge_aktiv_card_widget.dart';
import 'package:pushpals/enums/enum_challenge_status.dart';

class GetChallengeWidget extends StatelessWidget {
  final Map<String, dynamic> challengeData;

  const GetChallengeWidget({super.key, required this.challengeData});

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
              'Wurde von ${challengeData['sender']['username']} herausgefordert',
          imagePath:
              challengeData['sender']['profile_image_url'] ??
              'assets/images/IT_Nerd.png',
          isNetworkImage: challengeData['sender']['profile_image_url'] != null,
        ),

        ChallengeAktivCardWidget(
          title: challengeData['exercise'] ?? 'Übung',
          imagePath: 'assets/images/IT_Nerd.png',
          fallbackText: 'Keine Bilder verfügbar',
          timeLimit: challengeData['time_limit'] ?? 'unbegrenzt',
          mode: 'Standard',
          repetitions: challengeData['repetitions'] ?? 0,
        ),
        
      ],
    );
  }
}
