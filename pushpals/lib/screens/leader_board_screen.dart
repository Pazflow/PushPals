import 'package:flutter/material.dart';
import 'package:pushpals/widgets/player_tile_widget.dart';
import 'package:pushpals/widgets/stats_card_widget.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),
        elevation: 0,
        title: const Text('Leaderboard', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StatsCard(level: 1, challenges: 2),
            const SizedBox(height: 24),
            const Text(
              'Top Spieler 🏆',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Column(
              children: const [
                PlayerTile(
                  rank: 1,
                  name: 'Nummer 1',
                  level: 1,
                  avatarUrl: '../assets/images/IT_Nerd.png',
                  color: Colors.orange,
                  icon: '👑',
                ),
                PlayerTile(
                  rank: 2,
                  name: 'Nummer 2',
                  level: 1,
                  avatarUrl: '../assets/images/IT_Nerd.png',
                  color: Colors.grey,
                  icon: '🥈',
                ),
                PlayerTile(
                  rank: 3,
                  name: 'Nummer 3',
                  level: 1,
                  avatarUrl: '../assets/images/IT_Nerd.png',
                  color: Colors.brown,
                  icon: '🥉',
                ),
                PlayerTile(
                  rank: 4,
                  name: 'Nummer 4',
                  level: 1,
                  avatarUrl: '../assets/images/IT_Nerd.png',
                  color: Color.fromARGB(221, 219, 76, 76),
                  icon: 'Pl. 4',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
