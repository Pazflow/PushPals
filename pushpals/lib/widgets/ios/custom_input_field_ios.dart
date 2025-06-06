import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputFieldIOS extends StatelessWidget {
  final String hint;

  const CustomInputFieldIOS({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: hint,
      placeholderStyle: const TextStyle(color: Color(0x89FFFFFF)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF424242),
        borderRadius: BorderRadius.circular(8),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
