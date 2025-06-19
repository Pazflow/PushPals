import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pushpals/widgets/bild_avatar_widget.dart';
import 'package:pushpals/widgets/button_allg_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/eingabe_feld_widget.dart';

class ProfileSetupWidget extends StatelessWidget {
  const ProfileSetupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Profil Setup',
      showBack: false,
      showProfile: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          const AppAvatar(
            outerRadius: 70,
            innerRadius: 65,
            icon: Icons.add_a_photo,
          ),
          const SizedBox(height: 32),
          const CustomInputField(hint: 'Name'),
          const SizedBox(height: 16),
          const CustomInputField(hint: 'Birthday'),
          const SizedBox(height: 32),
          ButtonWidget(
            onPressed: () {
              GoRouter.of(context).go('/home');
            },
            label: 'Registrierung',
          ),
        ],
      ),
    );
  }
}
