import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/button_allg_widget.dart';
import 'package:pushpals/widgets/eingabe_feld_widget.dart';
import 'package:pushpals/widgets/passwort_vergessen_reset_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        await Supabase.instance.client.auth.refreshSession();
        final currentUser = Supabase.instance.client.auth.currentUser;
        print("Eingeloggt als: ${currentUser?.email}");
        context.go('/home');
      } else {
        _showError('Login fehlgeschlagen.');
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user != null) {
        final insertResponse =
            await Supabase.instance.client.from('users').insert({
              'id': user.id,
              'email': email,
            }).select();

        print("Insert response: $insertResponse");

        if (!mounted) return;
        context.go('/after_registrierung');
      } else {
        if (!mounted) return;
        _showError('Registrierung fehlgeschlagen.');
      }
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: null,
      showAppBar: false,
      showBack: false,
      showProfile: false,
      showBottomNav: false,
      floatingActionButton: null,
      showFloatingButton: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Pushpals',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24),
          ),
          const SizedBox(height: 32),
          CustomInputField(hint: 'E-mail', controller: emailController),
          const SizedBox(height: 16),
          CustomInputField(
            hint: 'Passwort',
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 10),
          ForgotPasswordLink(emailController: emailController),
          const SizedBox(height: 25),
          ButtonWidget(onPressed: register, label: 'Registrieren'),
          const SizedBox(height: 16),
          ButtonWidget(
            onPressed: login,
            label: 'Login',
            backgroundColor: const Color(0xFFFFC107),
            foregroundColor: Colors.black,
            width: 100,
            height: 150,
            borderRadius: 20,
          ),
        ],
      ),
    );
  }
}
