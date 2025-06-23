import 'package:flutter/material.dart';
import 'dart:io';

class AppAvatar extends StatelessWidget {
  final double outerRadius;
  final double innerRadius;
  final IconData icon;
  final File? imageFile;

  const AppAvatar({
    super.key,
    required this.outerRadius,
    required this.innerRadius,
    required this.icon,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    final showImage = imageFile != null && imageFile!.existsSync();

    return CircleAvatar(
      radius: outerRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: innerRadius,
        backgroundImage: showImage ? FileImage(imageFile!) : null,
        child: !showImage ? Icon(icon, size: 40) : null,
      ),
    );
  }
}
