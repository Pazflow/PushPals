import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSetupModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  String? username;
  DateTime? birthday;
  Uint8List? profileImageBytes;
  String? profileImageUrl;

  // Bild auswählen (funktioniert auf Web & Mobile)
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImageBytes = await picked.readAsBytes();
      notifyListeners();
    }
  }

  // Bild in Supabase hochladen (für Web und Mobile)
  Future<void> uploadProfileImage(String userId) async {
    if (profileImageBytes == null) return;

    final imageName = '${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await _client.storage
        .from('profile.images')
        .uploadBinary(imageName, profileImageBytes!);

    profileImageUrl = _client.storage
        .from('profile.images')
        .getPublicUrl(imageName);
    notifyListeners();
  }

  // Daten in Supabase (public.users) speichern
  Future<void> saveUserData() async {
    final authUser = _client.auth.currentUser;
    if (authUser == null) throw Exception("User not logged in");

    await uploadProfileImage(authUser.id);

    await _client.from('users').insert({
      'id': authUser.id,
      'username': username,
      'birthday': birthday?.toIso8601String(),
      'profile_image_url': profileImageUrl,
      'email': authUser.email,
      'level': 1,
      'friend_request_status': 'none',
      'challenges_completed': 0,
    });
  }

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }

  void setBirthday(DateTime value) {
    birthday = value;
    notifyListeners();
  }
}
