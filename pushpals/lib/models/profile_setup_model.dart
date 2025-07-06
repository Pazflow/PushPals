import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Profile Setup
class ProfileSetupModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  String? username;
  DateTime? birthday;
  Uint8List? profileImageBytes;
  String? profileImageUrl;

  int level = 1; // ➕ NEU
  int challengesCompleted = 0; // ➕ NEU

  bool isLoading = false;

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

  Future<void> loadUserData() async {
    isLoading = true;
    notifyListeners();

    final user = _client.auth.currentUser;
    if (user == null) {
      isLoading = false;
      notifyListeners();
      return;
    }

    final response =
        await _client.from('users').select().eq('id', user.id).single();

    username = response['username'] ?? 'Kein Name';
    final bday = response['birthday'];
    if (bday != null) {
      birthday = DateTime.tryParse(bday);
    }
    profileImageUrl = response['profile_image_url'] ?? '';

    // ➕ NEU: Level und Challenges laden
    level = response['level'] ?? 1;
    challengesCompleted = response['challenges_completed'] ?? 0;

    isLoading = false;
    notifyListeners();
  }

  // Daten in Supabase (public.users) speichern
  Future<void> saveUserData() async {
    final authUser = _client.auth.currentUser;
    if (authUser == null) throw Exception("User not logged in");

    await uploadProfileImage(authUser.id);

    try {
      await _client.from('users').upsert({
        'id': authUser.id,
        'username': username,
        'birthday': birthday?.toIso8601String(),
        'profile_image_url': profileImageUrl,
        'email': authUser.email,
        'level': level, // ➕ mitnehmen
        'friend_request_status': 'none',
        'challenges_completed': challengesCompleted, // ➕ mitnehmen
      });
      print("Benutzerdaten erfolgreich gespeichert.");
    } catch (e) {
      print("Fehler beim Speichern der Benutzerdaten");
    }
    await Supabase.instance.client.auth.updateUser(
      UserAttributes(data: {'display_name': username}),
    );
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
