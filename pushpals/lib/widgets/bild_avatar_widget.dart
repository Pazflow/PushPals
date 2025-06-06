import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final double outerRadius;
  final double innerRadius;
  final IconData icon;

  const AppAvatar({
    super.key,
    this.outerRadius = 48,
    this.innerRadius = 44,
    this.icon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: outerRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: innerRadius,
        backgroundColor: Colors.blue,
        child: Icon(icon, color: Colors.white, size: 40),
      ),
    );
  }
}
