import 'package:flutter/material.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/bottom_navbar_widget.dart';
import 'package:pushpals/widgets/rangliste_spieler_card_widget.dart';
import 'package:pushpals/widgets/statistik_card_widget.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      showProfile: true,
      title: 'Leaderborad',
      bottomWidget: BottomNavWidget(currentIndex: 0, onTap: (index) {}),
      floatingActionButton: SizedBox(
        height: 48,
        width: 48,
        child: FloatingActionButton(
          onPressed: () {},
          shape: CircleBorder(),
          child: Icon(Icons.add, size: 48, ),
          
        ),
      ),

      child: SingleChildScrollView(
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
            const PlayerTile(
              rank: 2,
              name: 'Papa',
              level: 3,
              avatarUrl: '../assets/images/IT_Nerd.png',
              color: Color.fromARGB(255, 10, 32, 71),
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
            const PlayerTile(
              rank: 2,
              name: 'Papa',
              level: 3,
              avatarUrl: '../assets/images/IT_Nerd.png',
              color: Color.fromARGB(255, 10, 32, 71),
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
      ),
    );
  }
}
