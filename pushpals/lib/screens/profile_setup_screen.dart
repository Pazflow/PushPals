import 'package:flutter/material.dart';
import 'package:pushpals/widgets/app_avatar_widget.dart';
import 'package:pushpals/widgets/app_design_widget.dart';
import 'package:pushpals/widgets/custom_input_field_widget.dart';
import 'package:pushpals/widgets/save_button_widget.dart';

class ProfileSetupWidget extends StatelessWidget {
  const ProfileSetupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Profil Setup',
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
          SaveButton(onPressed: () {}),
        ],
      ),
    );
  }
}
