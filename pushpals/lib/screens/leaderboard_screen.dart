import 'package:flutter/material.dart';
import 'package:pushpals/widgets/app_design_own_widget.dart';
import 'package:pushpals/widgets/bestof_card_widget.dart';
import 'package:pushpals/widgets/statistic_card_widget.dart';
import 'package:pushpals/models/friend_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; 

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> friends = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFriends();
  }

  Future<void> loadFriends() async {
    final data = await fetchFriendsWithStats();

    final client = Supabase.instance.client;
    final user = client.auth.currentUser;

    if (user == null) return;

    final userResponse =
        await client.from('users').select().eq('id', user.id).single();

    data.add(userResponse);

    
    data.sort((a, b) => (b['level'] ?? 0).compareTo(a['level'] ?? 0));

    setState(() {
      friends = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      showProfile: true,
      title: 'Leaderboard',
      selectedIndex: 1,
      child:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StatsCard(),
                    const SizedBox(height: 24),
                    const Text(
                      'Top Spieler 🏆',
                      style: TextStyle(
                        color: Color(0xFFCBB90F),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...friends.asMap().entries.map((entry) {
                      final index = entry.key;
                      final friend = entry.value;

                      return PlayerTile(
                        rank: index + 1,
                        name: friend['username'] ?? 'Unbekannt',
                        level: friend['level'] ?? 0,
                        challenge: friend['challenges_completed'] ?? 0,
                        avatarUrl: friend['profile_image_url'] ?? '',
                        color: Colors.blueAccent,
                        icon: Icons.military_tech,
                      );
                    }).toList(),
                  ],
                ),
              ),
    );
  }
}
