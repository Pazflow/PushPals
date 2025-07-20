import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 48,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 44,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.account_circle, color: Colors.white, size: 40),
      ),
    );
  }
}
