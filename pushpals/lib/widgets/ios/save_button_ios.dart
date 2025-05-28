import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: CupertinoColors.systemPurple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        child: const Text(
          'Save',
          style: TextStyle(
            color: CupertinoColors.systemPurple,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
