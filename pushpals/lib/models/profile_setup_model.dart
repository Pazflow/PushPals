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

  int level = 0;                
  int challengesCompleted = 0;  

  bool isLoading = false;

  
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImageBytes = await picked.readAsBytes();
      notifyListeners();
    }
  }

  
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

    
    level = response['level'] ?? 1;
    challengesCompleted = response['challenges_completed'] ?? 0;

    isLoading = false;
    notifyListeners();
  }

  
  Future<void> saveUserData() async {
    final authUser = _client.auth.currentUser;
    if (authUser == null) throw Exception("User not logged in");

    await uploadProfileImage(authUser.id);

    try {
      final updateData = {
        'id': authUser.id,
        'email': authUser.email,
        'profile_image_url': profileImageUrl,
        'level': level,
        'friend_request_status': 'none',
        'challenges_completed': challengesCompleted,
      };

      if (username != null && username!.isNotEmpty) {
        updateData['username'] = username;
      }

      if (birthday != null) {
        updateData['birthday'] = birthday!.toIso8601String();
      }

      await _client.from('users').upsert(updateData);
      print("Benutzerdaten erfolgreich gespeichert.");
    } catch (e) {
      print("Fehler beim Speichern der Benutzerdaten: $e");
    }

    
    try {
      if (username != null && username!.isNotEmpty) {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(data: {'display_name': username}),
        );
      }
    } catch (e) {
      print("⚠️ Fehler beim auth.updateUser: $e");
    }
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
