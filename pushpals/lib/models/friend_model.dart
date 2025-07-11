import 'package:supabase_flutter/supabase_flutter.dart';

class Friend {
  final String id;
  final String username;
  final String profileImageUrl;

  Friend({
    required this.id,
    required this.username,
    required this.profileImageUrl,
  });

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      id: map['id'] ?? '',
      username: map['username'] ?? 'Unbekannt',
      profileImageUrl: map['profile_image_url'] ?? '',
    );
  }
}

Future<List<Map<String, dynamic>>> fetchFriendsWithStats() async {
  final client = Supabase.instance.client;
  final user = client.auth.currentUser;

  if (user == null) throw Exception("Nicht eingeloggt");

  final response = await client
      .from('friend_requests')
      .select()
      .or('sender_id.eq.${user.id},receiver_id.eq.${user.id}')
      .eq('status', 'accepted');

  List<String> friendIds = [];

  for (final req in response) {
    if (req['sender_id'] != user.id) {
      friendIds.add(req['sender_id']);
    } else {
      friendIds.add(req['receiver_id']);
    }
  }

  if (friendIds.isEmpty) {
    return [];
  }

  // Query-String OHNE Anführungszeichen bauen
  final ids = friendIds.join(',');

  final friendsResponse = await client
      .rpc('get_users_by_ids', params: {'user_ids': ids});

  return List<Map<String, dynamic>>.from(friendsResponse);
}




