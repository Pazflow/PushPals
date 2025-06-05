import 'package:flutter/material.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/eigenes_profil_card_widget.dart';
import 'package:pushpals/widgets/einstellungen_card_widget.dart';
import 'package:pushpals/widgets/statistik_card_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Profile Screen',
      child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AvatarCard(
            name: 'Mobile',
            birthdate: '2025-02-18',
            avatarPath: '../assets/images/IT_Nerd.png',
          ),
          const SizedBox(height: 16),
          const StatsCard(level: 2, challenges: 4),
          const SizedBox(height: 16),
          const SettingsCard(),
        ],
      ),
      )
      
    );
  }
}
