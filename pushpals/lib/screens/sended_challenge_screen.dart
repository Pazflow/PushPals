import 'package:flutter/material.dart';
import 'package:pushpals/widgets/aktiv_card_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/challenge_aktiv_card_widget.dart';
import 'package:pushpals/widgets/bottom_navbar_widget.dart';
import 'package:pushpals/widgets/status_card_widget.dart';
import 'package:pushpals/widgets/floatingbutton_widget.dart';

class SendChallengeScreen extends StatelessWidget {
  const SendChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      showBack: true,
      showProfile: true,
      title: 'Challenge Details',
      floatingActionButton: FloatingButtonWidget(onPressed: (){}, icon: Icons.add),
      bottomWidget: BottomNavWidget(currentIndex: 0, onTap: (index) {}),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StatusDisplayWidget(),
            const SizedBox(height: 15,),
            const AktivCardWidget(),
            const SizedBox(height: 15,),
            const ChallengeAktivCardWidget(),
            
          ],
        ),
      ),
    );
  }
}