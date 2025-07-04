import 'package:flutter/material.dart';
import 'package:pushpals/widgets/aktiv_card_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/challenge_aktiv_card_widget.dart';
import 'package:pushpals/widgets/beweis_card_widget.dart';
import 'package:pushpals/widgets/status_card_widget.dart';


class GetChallengeScreen extends StatelessWidget {
  const GetChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      showBack: true,
      showProfile: true,
      
      title: 'Challenge Details',
      selectedIndex: 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StatusDisplayWidget(),
            const SizedBox(height: 15),
            const AktivCardWidget(),
            const SizedBox(height: 15),
            const ChallengeAktivCardWidget(),
            const SizedBox(height: 15),
            const BeweisCardWidget(),
          ],
        ),
      ),
    );
  }
}
