import 'package:flutter/material.dart';

class PasswortVergessenScreen extends StatelessWidget {
  const PasswortVergessenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Passwort zurücksetzen')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('E-Mail eingeben, um dein Passwort zurückzusetzen:'),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(labelText: 'E-Mail'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Supabase Password-Reset-Logik
              },
              child: const Text('Zurücksetzen'),
            )
          ],
        ),
      ),
    );
  }
}
