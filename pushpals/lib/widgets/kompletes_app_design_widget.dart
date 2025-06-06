import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDesign extends StatelessWidget {
  final String? title;
  final Widget child;
  final bool showBack;
  final bool showProfile;
  final Widget? floatingActionButton;
  final int selectedIndex;
  final bool showBottomNav;

  const AppDesign({
    super.key,
    this.title,
    required this.child,
    this.showBack = true,
    this.showProfile = true,
    this.floatingActionButton,
    this.selectedIndex = 0,
    this.showBottomNav = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 33, 33),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 142, 138, 138),
        elevation: 0,
        leading:
            showBack
                ? BackButton(
                  color: Colors.white,
                  onPressed: () => context.go('/home')

                )
                : null,
        title:
            title != null
                ? Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
                : null,
        centerTitle: false,
        actions:
            showProfile
                ? [
                  IconButton(
                    icon: const Icon(Icons.account_circle, color: Colors.white),
                    onPressed: () {
                      context.go('/profil'); // << ZENTRAL definiert
                    },
                  ),
                ]
                : null,
      ),
      body: Padding(padding: const EdgeInsets.all(24), child: child),
      floatingActionButton:
          floatingActionButton ??
          FloatingActionButton(
            onPressed: () => context.go('/challenge_hinzufuegen'), // << ZENTRAL
            child: const Icon(Icons.add),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
          showBottomNav
              ? BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context.go('/home'); // << ZENTRAL
                      break;
                    case 1:
                      context.go('/leaderboard'); // << ZENTRAL
                      break;
                  }
                },
                backgroundColor: Colors.black,
                selectedItemColor: Colors.purple,
                unselectedItemColor: Colors.white,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.leaderboard),
                    label: 'Leaderboard',
                  ),
                ],
              )
              : null,
    );
  }
}
