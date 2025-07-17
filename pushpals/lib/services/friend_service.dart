import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/friend_model.dart';

class FriendService {
  final client = Supabase.instance.client;

  Future<List<Friend>> fetchFriends() async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return [];

    final data = await client
        .from('friends')
        .select(
          'id, friend_id, users:friend_id(id, username, profile_image_url)',
        )
        .eq('user_id', userId);

    print('Fetched data from Supabase: $data');

    final Map<String, Friend> uniqueMap = {};
    for (final item in data) {
      final user = item['users'];
      final friendId = item['friend_id'];

      if (!uniqueMap.containsKey(friendId)) {
        uniqueMap[friendId] = Friend(
          id: friendId ?? '',
          username: user?['username'] ?? 'Unbekannt',
          profileImageUrl: user?['profile_image_url'] ?? '',
        );
      }
    }

    return uniqueMap.values.toList();
  }

  Future<void> deleteFriend(String friendId) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    // Einseitig löschen
    await client.from('friends').delete().match({
      'user_id': userId,
      'friend_id': friendId,
    });

    // Optional zweiseitig löschen:
    await client.from('friends').delete().match({
      'user_id': friendId,
      'friend_id': userId,
    });
  }
}
