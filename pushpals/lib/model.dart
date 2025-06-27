// model.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSetupModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  String? username;
  DateTime? birthday;
  File? profileImageFile;
  String? profileImageUrl;

  // Bild auswählen
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      if (await file.exists()) {
        profileImageFile = file;
        notifyListeners();
      } else {
        print("⚠️ Bilddatei existiert nicht: ${picked.path}");
      }
    }
  }

  // Bild in Supabase hochladen
  Future<void> uploadProfileImage(String userId) async {
    if (profileImageFile == null) return;

    final imageName = '${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final storageResponse = await _client.storage
        .from('profile.images')
        .upload(imageName, profileImageFile!);

    profileImageUrl = _client.storage
        .from('profile.images')
        .getPublicUrl(imageName);
    notifyListeners();
  }

  // Speichern der Daten in public.users
  Future<void> saveUserData() async {
    final authUser = _client.auth.currentUser;
    if (authUser == null) throw Exception("User not logged in");

    await uploadProfileImage(authUser.id);

    await _client.from('users').update({
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
