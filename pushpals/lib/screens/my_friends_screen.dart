import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pushpals/widgets/button_allg_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/friend_tile_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pushpals/models/friend_model.dart'; // Pfad anpassen
import 'package:pushpals/widgets/freunde_anfragen_dynamisch_widget.dart';

class MyFriendsScreen extends StatefulWidget {
  const MyFriendsScreen({super.key});

  @override
  State<MyFriendsScreen> createState() => _MyFriendsScreenState();
}

class _MyFriendsScreenState extends State<MyFriendsScreen> {
  List<Friend> _friends = [];
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

  Future<List<Friend>> _fetchFriends() async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;

    if (userId == null) return [];

    final data = await client
        .from('friends')
        .select('friend_id')
        .eq('user_id', userId);

    List<Friend> friends = [];

    for (var entry in data) {
      final friendId = entry['friend_id'];

      final userData = await client
          .from('users')
          .select('username, profile_image_url')
          .eq('id', friendId)
          .maybeSingle();

      if (userData != null) {
        friends.add(Friend.fromMap({
          'id': friendId,
          'username': userData['username'],
          'profile_image_url': userData['profile_image_url'],
        }));
      }
    }

    return friends;
  }

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Herausforderungen',
      selectedIndex: 2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ButtonWidget(
              onPressed: () {
                GoRouter.of(context).go('/freund_einladen');
              },
              label: 'Freund einladen',
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              onPressed: () {
                GoRouter.of(context).go('/challenge_hinzufuegen');
              },
              label: 'Challenge erstellen',
            ),
            const SizedBox(height: 30),
            FriendRequestListWidget(onActionCompleted: _loadFriends),
            const Text(
              'Meine Freunde',
              style: TextStyle(
                color: Color(0xFFCBB90F),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoadingFriends)
              const Center(child: CircularProgressIndicator())
            else
              ..._friends.map((friend) => FriendTile(
                    friend: friend,
                    onDelete: () {
                      // TODO: Löschen implementieren
                    },
                  )).toList(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
