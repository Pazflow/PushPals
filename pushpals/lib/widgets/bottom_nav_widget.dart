import 'package:flutter/material.dart';

class BottomNavWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool showLabels;

  const BottomNavWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showLabels = false,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      showSelectedLabels: showLabels,
      showUnselectedLabels: showLabels,
      backgroundColor: const Color(0xFF2196F3),
      selectedItemColor: const Color(0xFFFFFFFF),
      unselectedItemColor: const Color(0xFFFFFFFF),
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard, size: 20,),
          label: 'Rangliste',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Color(0xFF2196F3), size: 30,),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 20,),
          label: 'Profil',
        ),
      ],
    );
  }
}
