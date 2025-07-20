import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pushpals/widgets/image_avatar_widget.dart';
import 'package:pushpals/widgets/basebutton_widget.dart';
import 'package:pushpals/widgets/app_design_own_widget.dart';
import 'package:pushpals/widgets/input_field_widget.dart';
import 'package:pushpals/models/profile_setup_model.dart';

class ProfileSetupWidget extends StatefulWidget {
  const ProfileSetupWidget({super.key});

  @override
  State<ProfileSetupWidget> createState() => _ProfileSetupWidgetState();
}

class _ProfileSetupWidgetState extends State<ProfileSetupWidget> {
  final ProfileSetupModel model = ProfileSetupModel();
  final nameController = TextEditingController();
  final birthdayController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        birthdayController.text =
            "${picked.day}.${picked.month}.${picked.year}";
        model.setBirthday(picked);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Profile Setup',
      showBack: false,
      showProfile: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              await model.pickImage();
              setState(() {}); 
            },
            child: AppAvatar(
              outerRadius: 70,
              innerRadius: 65,
              icon: Icons.add_a_photo,
              imageBytes:
                  model
                      .profileImageBytes, 
            ),
          ),
          const SizedBox(height: 32),
          CustomInputField(
            hint: 'Name',
            controller: nameController,
            onChanged: model.setUsername,
          ),
          const SizedBox(height: 16),
          CustomInputField(
            hint: 'Birthday',
            controller: birthdayController,
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
          const SizedBox(height: 32),
          ButtonWidget(
            onPressed: () async {
              await model.saveUserData();
              if (context.mounted) {
                GoRouter.of(context).go('/home');
              }
            },
            label: 'Registrierung',
          ),
        ],
      ),
    );
  }
}
