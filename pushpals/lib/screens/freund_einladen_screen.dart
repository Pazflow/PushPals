import 'package:flutter/material.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/freunde_einladen_card_widget.dart';
import 'package:pushpals/widgets/friend_tile_widget.dart';
import 'package:pushpals/widgets/freunde_anfragen_dynamisch_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FriendSearchScreen extends StatefulWidget {
  const FriendSearchScreen({super.key});

  @override
  State<FriendSearchScreen> createState() => _FriendSearchScreenState();
}

class _FriendSearchScreenState extends State<FriendSearchScreen> {
  List<Map<String, dynamic>> _friends = [];
  bool _isLoadingFriends = true;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    final friends = await _fetchFriends();
    setState(() {
      _friends = friends;
      _isLoadingFriends = false;
    });
  }

  Future<List<Map<String, dynamic>>> _fetchFriends() async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;

    if (userId == null) return [];

    final data = await client
        .from('friends')
        .select('friend_id')
        .eq('user_id', userId);

    List<Map<String, dynamic>> friends = [];

    for (var entry in data) {
      final friendId = entry['friend_id'];

      final userData =
          await client
              .from('users')
              .select('username, profile_image_url')
              .eq('id', friendId)
              .maybeSingle();

      if (userData != null) {
        friends.add({
          'id': friendId,
          'username': userData['username'],
          'profile_image_url': userData['profile_image_url'],
        });
      }
    }

    return friends;
  }

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Freund einladen',
      selectedIndex: 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FriendSearchCard(),
            const SizedBox(height: 20),
            FriendRequestListWidget(onActionCompleted: _loadFriends),
            const SizedBox(height: 20),
            if (_isLoadingFriends)
              const Center(child: CircularProgressIndicator())
            else if (_friends.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Keine Freunde vorhanden.',
                  style: TextStyle(color: Colors.white),
                ),
              )
            else
              Column(
                children:
                    _friends.map((friend) {
                      return FriendTile(
                        name: friend['username'] ?? 'Unbekannt',
                        subtitle: 'Friend',
                        imagePath: friend['profile_image_url'] ?? '',
                        backgroundcolor: Colors.blueGrey,
                        onDelete: () {
                          // Optional: Freund löschen
                        },
                      );
                    }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
