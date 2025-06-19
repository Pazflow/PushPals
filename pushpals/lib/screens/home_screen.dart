import 'package:flutter/material.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/challange_card_widget.dart';
import 'package:pushpals/widgets/challenge_status.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      showBack: false,
      showProfile: true,
      title: 'PushPals',
      selectedIndex: 0,
      
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ChallengeCard(status: ChallengeStatus.failed,),
            const ChallengeCard(),
            const ChallengeCard(status: ChallengeStatus.accepted,),
            const ChallengeCard(),
            const ChallengeCard(status: ChallengeStatus.completed,),
            const ChallengeCard(status: ChallengeStatus.inProgress,),
            const ChallengeCard(),
            const ChallengeCard(status: ChallengeStatus.pending,),
            const ChallengeCard(),
          ],
        ),
      ),
    );
  }
}
