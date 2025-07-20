import 'dart:typed_data';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final double outerRadius;
  final double innerRadius;
  final IconData icon;
  final Uint8List? imageBytes;

  const AppAvatar({
    super.key,
    required this.outerRadius,
    required this.innerRadius,
    required this.icon,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: outerRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: innerRadius,
        backgroundImage: imageBytes != null ? MemoryImage(imageBytes!) : null,
        child: imageBytes == null ? Icon(icon, size: 40) : null,
      ),
    );
  }
}
