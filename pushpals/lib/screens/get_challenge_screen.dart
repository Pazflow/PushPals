import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'package:pushpals/models/proof_image_model.dart';
import 'package:pushpals/widgets/beweis_card_widget.dart';
import 'package:pushpals/widgets/status_card_widget.dart';
import 'package:pushpals/widgets/aktiv_card_widget.dart';
import 'package:pushpals/widgets/challenge_aktiv_card_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/enums/enum_challenge_status.dart';

class GetChallengeScreen extends StatelessWidget {
  const GetChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ChallengeModel>(context);
    final challenge = model.selectedChallenge;

    if (challenge == null) {
      return Scaffold(body: Center(child: Text('Keine Challenge ausgewählt')));
    }

    final challengeId = challenge['id'];
    final statusString = challenge['challenge_status'] ?? 'pending';
    final statusEnum = convertStatusStringToEnum(statusString);
    final proofUrl = challenge['proof_picture_url'] ?? '';
    print("DEBUG URL: $proofUrl");

    final proofModel = ProofImageModel();

    // Bild beim Screen-Start laden
    if (proofUrl != null && proofUrl.isNotEmpty) {
      proofModel.loadProofImageFromUrl(proofUrl);
    } else {
      print("ℹ️ Keine gültige URL in DB, skip loading");
    }

    return AppDesign(
      showBack: true,
      showProfile: true,
      title: 'meine Challenge',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusDisplayWidget(status: statusEnum),
            AktivCardWidget(
              profileName: challenge['exercise'] ?? 'Unbekannt',
              subtitle: 'Von ${challenge['sender']['username'] ?? 'Unbekannt'}',
              imagePath:
                  challenge['sender']['profile_image_url'] ??
                  'assets/images/IT_Nerd.png',
              isNetworkImage: challenge['sender']['profile_image_url'] != null,
            ),
            ChallengeAktivCardWidget(
              title: challenge['exercise'] ?? 'Übung',
              imagePath: 'assets/images/IT_Nerd.png',
              fallbackText: 'Keine Bilder verfügbar',
              timeLimit: challenge['time_limit'] ?? 'unbegrenzt',
              mode: 'Standard',
              repetitions: challenge['repetitions'] ?? 0,
            ),
            BeweisCardWidget(challengeId: challengeId, proofModel: proofModel),
          ],
        ),
      ),
    );
  }
}
