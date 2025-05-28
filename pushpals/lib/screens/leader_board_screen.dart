import 'package:flutter/material.dart';
import 'package:pushpals/widgets/app_design_widget.dart';
import 'package:pushpals/widgets/bottom_nav_widget.dart';
import 'package:pushpals/widgets/player_tile_widget.dart';
import 'package:pushpals/widgets/stats_card_widget.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Leaderborad',
      bottomWidget: BottomNavWidget(currentIndex: 0, onTap: (index){}),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatsCard(level: 1, challenges: 2),
          const SizedBox(height: 24),
          const Text(
            'Top Spieler 🏆',
            style: TextStyle(
              color: Color.fromARGB(255, 203, 185, 15),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const PlayerTile(
            rank: 2,
            name: 'Mama',
            level: 3,
            avatarUrl: '../assets/images/IT_Nerd.png',
            color: Colors.blueAccent,
            icon: Icons.military_tech,
          ),
          const PlayerTile(
            rank: 2,
            name: 'Papa',
            level: 3,
            avatarUrl: '../assets/images/IT_Nerd.png',
            color: Color.fromARGB(255, 10, 32, 71),
            icon: Icons.military_tech,
          ),
        ],
      ),
      
    );
    
  }
}
