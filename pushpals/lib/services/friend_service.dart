import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/friend_model.dart';

class FriendService {
  final client = Supabase.instance.client;

  Future<List<Friend>> fetchFriends() async {
    final userId = client.auth.currentUser?.id;

    if (userId == null) return [];

    final data = await client
        .from('friends')
        .select('id, users:friend_id(username, profile_image_url)')
        .eq('user_id', userId);
    print('Fetched data from Supabase: $data');

    return (data as List).map((item) {
      final user = item['users'];
      return Friend(
        id: item['id'] ?? '',
        username: user?['username'] ?? 'Unbekannt',
        profileImageUrl: user?['profile_image_url'] ?? '',
      );
    }).toList();
  }
}
