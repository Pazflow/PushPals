import 'package:flutter/material.dart';

class AppDesign extends StatelessWidget {
  final String? title;
  final Widget child;
  final bool showBack;
  final Widget? bottomWidget;
  final bool showProfile;
  final VoidCallback? onProfileTap;
  final Widget? floatingActionButton;

  const AppDesign({
    super.key,
    this.title,
    required this.child,
    this.showBack = true,
    this.bottomWidget,
    this.showProfile = true,
    this.onProfileTap,
    this.floatingActionButton,
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
        actions: showProfile
            ? [
                IconButton(
                  icon: const Icon(Icons.account_circle, color: Colors.white),
                  onPressed: onProfileTap,
                )
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: child,
      ),
      bottomNavigationBar: bottomWidget,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
    );
  }
}
