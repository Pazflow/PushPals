import 'package:flutter/material.dart';
import 'package:pushpals/widgets/app_design_widget.dart';
import 'package:pushpals/widgets/custom_card_widget.dart';
import 'package:pushpals/widgets/setting_card_widget.dart';
import 'package:pushpals/widgets/stats_card_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Profile Screen',
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
    );
  }
}
