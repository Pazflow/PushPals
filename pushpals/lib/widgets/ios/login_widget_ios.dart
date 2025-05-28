import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
            CupertinoTextField(
              placeholder: 'Email',
              placeholderStyle: TextStyle(color: Color(0x89FFFFFF)),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF424242),
                borderRadius: BorderRadius.circular(8),
              ),
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
            SizedBox(height: 16),
            CupertinoTextField(
              placeholder: 'Passwort',
              placeholderStyle: TextStyle(color: Color(0x89FFFFFF)),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF424242),
                borderRadius: BorderRadius.circular(8),
              ),
              style: TextStyle(color: Color(0xFFFFFFFF)),
              obscureText: true,
            ),
            SizedBox(height: 25),
            CupertinoButton(
              onPressed: () {},
              color: Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(8),
              child: Text('Button_Registrieren', style: TextStyle(color: Color(0xFFFFFFFF))),
            ),
            SizedBox(height: 16),
            CupertinoButton(
              onPressed: () {},
              color: Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(8),
              child: Text('Button_Login', style: TextStyle(color: Color(0xFFFFFFFF))),
            ),
          ],
        ),
      ),
    );
  }
}
