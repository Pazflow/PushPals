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


