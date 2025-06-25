import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pushpals/widgets/bild_avatar_widget.dart';
import 'package:pushpals/widgets/button_allg_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/eingabe_feld_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ProfileSetupWidget extends StatefulWidget {
  const ProfileSetupWidget({super.key});

  @override
  State<ProfileSetupWidget> createState() => _ProfileSetupWidgetState();
}

class _ProfileSetupWidgetState extends State<ProfileSetupWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  bool _isLoading = false;

  Future<void> _completeProfileSetup() async {
    final name = _nameController.text.trim();
    final birthdayText = _birthdayController.text.trim();
    final user = Supabase.instance.client.auth.currentUser;

    if (name.isEmpty || birthdayText.isEmpty || user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte Name und Geburtstag ausfüllen.')),
      );
      return;
    }

    DateTime? birthday;
    try {
      birthday = DateTime.parse(birthdayText);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Geburtstag im Format YYYY-MM-DD eingeben.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 👇 check ob user bereits in Tabelle ist
      final existing = await Supabase.instance.client
          .from('users')
          .select('id')
          .eq('id', user.id)
          .maybeSingle();

      if (existing == null) {
        // 👇 falls nicht vorhanden, erst einfügen
        await Supabase.instance.client.from('users').insert({
          'id': user.id,
          'email': user.email,
          'username': name,
          'birthday': birthday.toIso8601String(),
        });
      } else {
        // 👇 falls vorhanden, aktualisieren
        await Supabase.instance.client.from('users').update({
          'username': name,
          'birthday': birthday.toIso8601String(),
        }).eq('id', user.id);
      }

      // 👇 Auth-Profil (display_name) aktualisieren
      await Supabase.instance.client.auth.updateUser(UserAttributes(
        data: {'display_name': name},
      ));

      if (!mounted) return;
      GoRouter.of(context).go('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('FEHLER: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
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
              //await model.pickImage();
              setState(() {}); // Bild aktualisieren
            },
            child: AppAvatar(
              outerRadius: 70,
              innerRadius: 65,
              icon: Icons.add_a_photo,
              // <- Muss im Avatar Widget unterstützt werden
            ),
          ),
          const SizedBox(height: 32),
          CustomInputField(hint: 'Name', controller: _nameController),
          const SizedBox(height: 16),
          CustomInputField(hint: 'Birthday (YYYY-MM-DD)', controller: _birthdayController),
          const SizedBox(height: 32),
          ButtonWidget(
            onPressed: _isLoading ? null : _completeProfileSetup,
            label: _isLoading ? 'Speichere...' : 'Registrierung abschließen',
          ),
        ],
      ),
    );
  }
}
