import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/profile_setup_model.dart';
import 'package:pushpals/widgets/app_design_own_widget.dart';
import 'package:pushpals/widgets/own_profile_card_widget.dart';
import 'package:pushpals/widgets/setting_card_widget.dart';
import 'package:pushpals/widgets/statistic_card_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _load();
    });
  }

  Future<void> _load() async {
    final model = Provider.of<ProfileSetupModel>(context, listen: false);
    await model.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final profileModel = Provider.of<ProfileSetupModel>(context);

    return AppDesign(
      title: 'Profile Screen',
      selectedIndex: 1,
      child:
          profileModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvatarCard(
                      name: profileModel.username ?? 'Kein Name',
                      birthdate:
                          profileModel.birthday != null
                              ? DateFormat(
                                'dd.MM.yyyy',
                              ).format(profileModel.birthday!)
                              : 'Unbekannt',
                      avatarPath:
                          (profileModel.profileImageUrl != null &&
                                  profileModel.profileImageUrl!.isNotEmpty)
                              ? profileModel.profileImageUrl!
                              : 'assets/images/IT_Nerd.png',
                      profileImageBytes: profileModel.profileImageBytes,
                      onAvatarTap: () async {
                        await profileModel.pickImage();
                        final authUser =
                            Supabase.instance.client.auth.currentUser;
                        if (authUser != null) {
                          await profileModel.uploadProfileImage(authUser.id);
                          await profileModel.saveUserData();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const StatsCard(),
                    const SizedBox(height: 16),
                    const SettingsCard(),
                  ],
                ),
              ),
    );
  }
}
