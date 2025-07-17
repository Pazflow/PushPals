import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pushpals/widgets/button_allg_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/friend_tile_widget.dart';
import 'package:pushpals/services/friend_service.dart';
import 'package:pushpals/models/friend_model.dart';
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
    final friends = await FriendService().fetchFriends();
    setState(() {
      _friends = friends;
      _isLoadingFriends = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Freunde',
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
              ..._friends
                  .map(
                    (friend) => FriendTile(
                      friend: friend,
                      onDelete: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text('Freund entfernen'),
                                content: Text(
                                  'Möchtest du ${friend.username} wirklich aus deiner Freundesliste entfernen?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(false),
                                    child: const Text('Abbrechen'),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(true),
                                    child: const Text('Löschen'),
                                  ),
                                ],
                              ),
                        );

                        if (confirm == true) {
                          await FriendService().deleteFriend(friend.id);
                          await _loadFriends(); // Liste aktualisieren

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${friend.username} wurde entfernt',
                              ),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                    ),
                  )
                  .toList(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
