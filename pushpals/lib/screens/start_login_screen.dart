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

  bool? emailExists; // null = noch nicht geprüft
  bool isChecking = false;
  bool showEmailFormatError = false;

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> checkEmailExists(String email) async {
    setState(() {
      isChecking = true;
    });

    final response =
        await Supabase.instance.client
            .from('users')
            .select('email')
            .eq('email', email)
            .maybeSingle();

    setState(() {
      emailExists = response != null;
      isChecking = false;
    });
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("Bitte E-Mail und Passwort eingeben.");
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (response.user != null) {
        await Supabase.instance.client.auth.refreshSession();
        context.go('/home');
      } else {
        _showError('Login fehlgeschlagen.');
      }
    } catch (e) {
      final error = e is AuthException ? e.message : e.toString();
      _showError(error);
    }
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("Bitte E-Mail und Passwort eingeben.");
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user != null) {
        await Supabase.instance.client.from('users').insert({
          'id': user.id,
          'email': email,
        });
        context.go('/after_registrierung');
      } else {
        _showError('Registrierung fehlgeschlagen.');
      }
    } catch (e) {
      final error = e is AuthException ? e.message : e.toString();
      _showError(error);
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
          CustomInputField(
            hint: 'E-mail',
            controller: emailController,
            onChanged: (value) {
              final trimmed = value.trim();

              setState(() {
                emailExists = null;
                showEmailFormatError = false;
              });

              // Erst prüfen, ob E-Mail gültig ist (z. B. enthält @, .de, .com ...)
              if (isValidEmail(trimmed)) {
                checkEmailExists(trimmed); // Supabase prüfen
              } else if (trimmed.endsWith('.de') ||
                  trimmed.endsWith('.com') ||
                  trimmed.endsWith('.org')) {
                // Nur wenn Benutzer offenbar "fertig" ist → Fehler anzeigen
                setState(() {
                  showEmailFormatError = true;
                });
              }
            },
          ),
          if (showEmailFormatError)
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0),
              child: Text(
                'Bitte gib eine gültige E-Mail-Adresse ein.',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),

          if (emailExists != null) ...[
            const SizedBox(height: 16),
            CustomInputField(
              hint: 'Passwort',
              controller: passwordController,
              obscureText: true,
            ),
            if (emailExists == true) ...[
              const SizedBox(height: 10),
              ForgotPasswordLink(emailController: emailController),
            ],
          ],

          const SizedBox(height: 25),
          if (isChecking)
            const Center(child: CircularProgressIndicator())
          else if (emailExists == true)
            ButtonWidget(
              onPressed: login,
              label: 'Login',
              backgroundColor: const Color(0xFFFFC107),
              foregroundColor: Colors.black,
              width: 100,
              height: 150,
              borderRadius: 20,
            )
          else if (emailExists == false)
            ButtonWidget(onPressed: register, label: 'Registrieren'),
        ],
      ),
    );
  }
}
