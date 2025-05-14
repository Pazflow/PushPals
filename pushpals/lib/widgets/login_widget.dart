import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pushpals',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24),
            ),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: const Color(0x89FFFFFF)),
                filled: true,
                fillColor: const Color(0xFF424242),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: const Color(0xFFFFFFFF)),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Passwort',
                hintStyle: TextStyle(color: const Color(0x89FFFFFF)),
                filled: true,
                fillColor: const Color(0xFF424242),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: const Color(0xFFFFFFFF)),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                foregroundColor: const Color(0xFFFFFFFF),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Button_Registrieren'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                foregroundColor: const Color(0xFFFFFFFF),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Button_Login'),
            ),
          ],
        ),
      ),
    );
  }
}
