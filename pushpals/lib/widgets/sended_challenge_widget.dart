import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'status_card_widget.dart';
import 'active_card_widget.dart';
import 'challenge_activ_card_widget.dart';
import 'package:pushpals/enums/enum_challenge_status.dart';

class SendenChallengeWidget extends StatelessWidget {
  final Map<String, dynamic> challengeData;
  final String? gifUrl; 

  const SendenChallengeWidget({
    super.key,
    required this.challengeData,
    this.gifUrl,
  });

  @override
  Widget build(BuildContext context) {
    final statusString = challengeData['challenge_status'] ?? 'pending';
    final ChallengeStatus statusEnum = convertStatusStringToEnum(statusString);

    final challengeId = challengeData['id'].toString();

    
    final String? imageUrl =
        statusEnum == ChallengeStatus.completed
            ? challengeData['proof_picture_url']
            : context.read<ChallengeModel>().gifUrls[challengeId];

    
    final profileUrl = challengeData['receiver']['profile_image_url'];
    final isValidProfileImage =
        profileUrl != null &&
        profileUrl is String &&
        profileUrl.isNotEmpty &&
        profileUrl.startsWith('http');

    return Column(
      children: [
        StatusDisplayWidget(status: statusEnum),
        AktivCardWidget(
          profileName: challengeData['exercise'] ?? 'Unbekannt',
          subtitle:
              'Ich habe ${challengeData['receiver']['username']} herausgefordert',
          imagePath:
              isValidProfileImage ? profileUrl : 'assets/images/IT_Nerd.png',
          isNetworkImage: isValidProfileImage,
        ),
        ChallengeAktivCardWidget(
          title: challengeData['exercise'] ?? 'Übung',
          fallbackText: 'Keine Bilder verfügbar',
          timeLimit: challengeData['time_limit'] ?? 'unbegrenzt',
          mode: 'Standard',
          repetitions: challengeData['repetitions'] ?? 0,
          gifUrl: imageUrl, 
        ),
      ],
    );
  }
}
