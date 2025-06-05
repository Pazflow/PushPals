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
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 15,
      color: const Color(0xFF2196F3),
      child: PreferredSize(
        preferredSize: const Size.fromHeight(
          44,
        ), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.emoji_events,
              label: 'Rangliste',
              index: 0,
              isSelected: currentIndex == 0,
            ),
            const SizedBox(width: 48), 
            _buildNavItem(
              icon: Icons.group,
              label: 'Profil',
              index: 1,
              isSelected: currentIndex == 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: isSelected ? Colors.white : Colors.white70,
          ),
          if (showLabels)
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
