import 'package:flutter/material.dart';
import 'package:pushpals/widgets/button_allg_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/challange_card_widget.dart';
import 'package:pushpals/widgets/challenge_status.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      showBack: false,
      showProfile: true,
      title: 'PushPals - meine Challenges',
      selectedIndex: 0,

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ButtonWidget(
              onPressed: () {
                GoRouter.of(context).go('/challenge_uebersicht');
              },
              label: 'Meine Challenge Details',
            ),
            const SizedBox(height: 20),
            const ChallengeCard(status: ChallengeStatus.failed),

            const ChallengeCard(status: ChallengeStatus.accepted),

            const ChallengeCard(status: ChallengeStatus.completed),
            const ChallengeCard(status: ChallengeStatus.inProgress),

            const ChallengeCard(status: ChallengeStatus.pending),
          ],
        ),
      ),
    );
  }
}
