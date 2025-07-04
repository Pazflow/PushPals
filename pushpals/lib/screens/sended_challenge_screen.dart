import 'package:flutter/material.dart';
import 'package:pushpals/widgets/aktiv_card_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/challenge_aktiv_card_widget.dart';
import 'package:pushpals/widgets/status_card_widget.dart';

class SendChallengeScreen extends StatelessWidget {
  const SendChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      showBack: true,
      showProfile: true,
      title: 'zum Duell herausgefordert',
      selectedIndex: 3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StatusDisplayWidget(),
            const SizedBox(height: 15),
            const AktivCardWidget(),
            const SizedBox(height: 15),
            const ChallengeAktivCardWidget(),
          ],
        ),
      ),
    );
  }
}
