import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordLink extends StatelessWidget {
  final String route;
  final String text;
  final TextEditingController emailController;

  const ForgotPasswordLink({
    super.key,
    required this.emailController,
    this.route = '/passwort-vergessen',
    this.text = 'Passwort vergessen?',
  });

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          final email = emailController.text.trim();

          if (_isValidEmail(email)) {
            GoRouter.of(context).push(route);

          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bitte eine gültige E-Mail-Adresse eingeben'),
              ),
            );
          }
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
