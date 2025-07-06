import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProofImageModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  Uint8List? proofImageBytes;
  String? proofImageUrl;
  String? lastImageName;

  Future<void> pickImageAndUpload(String userId, String challengeId) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      proofImageBytes = await picked.readAsBytes();
      print("✅ Bild wurde aus Galerie geladen");
      notifyListeners();

      await uploadProofImage(userId, challengeId);
    }
  }

  Future<void> uploadProofImage(String userId, String challengeId) async {
    if (proofImageBytes == null) {
      print("⚠️ Kein Bild vorhanden zum Hochladen");
      return;
    }

    try {
      // Alte URL laden
      final response =
          await _client
              .from('challenges')
              .select('proof_picture_url')
              .eq('id', challengeId)
              .single();
      final oldUrl = response['proof_picture_url'] as String?;

      if (oldUrl != null && oldUrl.isNotEmpty) {
        final oldImageName = oldUrl.split('/').last;
        await _client.storage.from('proof.picture').remove([oldImageName]);
        print("🗑️ Altes Bild gelöscht: $oldImageName");
      }

      final imageName =
          '${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      await _client.storage
          .from('proof.picture')
          .uploadBinary(imageName, proofImageBytes!);

      final url = _client.storage.from('proof.picture').getPublicUrl(imageName);

      proofImageUrl = url;
      lastImageName = imageName;

      print("✅ Neues Bild erfolgreich hochgeladen: $url");

      await _client
          .from('challenges')
          .update({'proof_picture_url': proofImageUrl})
          .eq('id', challengeId);

      print("✅ Neue URL in Challenge gespeichert");
      notifyListeners();
    } catch (e) {
      print("❌ Fehler beim Hochladen: $e");
    }
  }

  Future<void> loadProofImageFromUrl(String url) async {
    if (url.isEmpty) {
      print("⚠️ Leere URL — kein Bild laden");
      return;
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        proofImageBytes = response.bodyBytes;
        proofImageUrl = url;
        print("✅ Bild aus URL geladen");
        notifyListeners();
      } else {
        print("❌ Fehler beim Laden der URL: Status ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Fehler beim Laden der URL: $e");
    }
  }
}
