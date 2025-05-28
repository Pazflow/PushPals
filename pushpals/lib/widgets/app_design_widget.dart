import 'package:flutter/material.dart';

class AppDesign extends StatelessWidget {
  final String? title;
  final Widget child;
  final bool showBack;
  final Widget? bottomWidget;

  const AppDesign({
    super.key,
    this.title,
    required this.child,
    this.showBack = true,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),
        elevation: 0,
        leading: showBack ? const BackButton(color: Colors.white) : null,
        title: title != null
            ? Text(
                title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: child,
      ),
      bottomNavigationBar: bottomWidget,
    );
  }
}
