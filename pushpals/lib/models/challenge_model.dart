import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChallengeModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final Map<String, String> _gifUrls = {};
  // Getter für die Challenge-GIF-URLs
  Map<String, String> get gifUrls =>
      _gifUrls; // key = challengeId, value = gifUrl

  String? selectedExercise;
  String? receiverId;
  String? timeLimit;
  int? repetitions;

  List<Map<String, dynamic>> receivedChallenges = [];
  List<Map<String, dynamic>> sentChallenges = [];
  List<Map<String, dynamic>> getChallenges = [];
  Map<String, dynamic>? selectedChallenge;

  RealtimeChannel? _receivedSubscription;
  RealtimeChannel? _sentSubscription;

  void setExercise(String value) {
    selectedExercise = value;
    notifyListeners();
  }

  void setReceiverId(String id) {
    receiverId = id;
    notifyListeners();
  }

  void setTimeLimit(String value) {
    timeLimit = value;
    notifyListeners();
  }

  void setRepetitions(String value) {
    repetitions = int.tryParse(value);
    notifyListeners();
  }

  void setSelectedChallenge(Map<String, dynamic> challenge) {
    selectedChallenge = challenge;

    final id = challenge['id'].toString();
    final exercise = challenge['exercise'] ?? '';
    if (exercise.isNotEmpty) {
      fetchGifForChallenge(id, exercise);
    }

    notifyListeners();
  }

  Future<void> submitChallenge() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("Not logged in");
    if (receiverId == null) throw Exception("Receiver not set");

    final challengeData = {
      'sender_id': user.id,
      'receiver_id': receiverId,
      'exercise': selectedExercise,
      'time_limit': timeLimit,
      'repetitions': repetitions,
      'challenge_status': 'pending',
    };

    await _client.from('challenges').insert(challengeData);
    print('Challenge erfolgreich gespeichert: $challengeData');
  }

  Future<void> loadReceivedChallenges() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("Nicht eingeloggt");

    final response = await _client
        .from('challenges')
        .select('*, sender:sender_id(username, profile_image_url)')
        .eq('receiver_id', user.id);

    receivedChallenges = List<Map<String, dynamic>>.from(response);

    // ➕ GIFs laden
    for (var challenge in receivedChallenges) {
      final id = challenge['id'].toString();
      final exercise = challenge['exercise'] ?? '';
      if (exercise.isNotEmpty) {
        await fetchGifForChallenge(id, exercise);
      }
    }

    notifyListeners();

    await _receivedSubscription?.unsubscribe();
    _receivedSubscription = null;

    _receivedSubscription =
        _client
            .channel('public:challenges')
            .onPostgresChanges(
              event: PostgresChangeEvent.insert,
              schema: 'public',
              table: 'challenges',
              callback: (payload) {
                final newChallenge = payload.newRecord;
                if (newChallenge['receiver_id'] == user.id) {
                  receivedChallenges.add(newChallenge);
                  notifyListeners();
                }
              },
            )
            .onPostgresChanges(
              event: PostgresChangeEvent.update,
              schema: 'public',
              table: 'challenges',
              callback: (payload) {
                final updatedChallenge = payload.newRecord;
                if (updatedChallenge['receiver_id'] == user.id) {
                  final index = receivedChallenges.indexWhere(
                    (c) => c['id'] == updatedChallenge['id'],
                  );
                  if (index != -1) {
                    receivedChallenges[index] = updatedChallenge;
                    notifyListeners();
                  }
                }
              },
            )
            .subscribe();
  }

  Future<void> loadSentChallenges() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("Nicht eingeloggt");

    final response = await _client
        .from('challenges')
        .select('*, receiver:receiver_id(username, profile_image_url)')
        .eq('sender_id', user.id);

    sentChallenges = List<Map<String, dynamic>>.from(response);

    // ➕ GIFs laden
    for (var challenge in sentChallenges) {
      final id = challenge['id'].toString();
      final exercise = challenge['exercise'] ?? '';
      if (exercise.isNotEmpty) {
        await fetchGifForChallenge(id, exercise);
      }
    }

    notifyListeners();

    await _sentSubscription?.unsubscribe();
    _sentSubscription = null;

    _sentSubscription =
        _client
            .channel('public:challenges')
            .onPostgresChanges(
              event: PostgresChangeEvent.insert,
              schema: 'public',
              table: 'challenges',
              callback: (payload) {
                final newChallenge = payload.newRecord;
                if (newChallenge['sender_id'] == user.id) {
                  sentChallenges.add(newChallenge);
                  notifyListeners();
                }
              },
            )
            .onPostgresChanges(
              event: PostgresChangeEvent.update,
              schema: 'public',
              table: 'challenges',
              callback: (payload) {
                final updatedChallenge = payload.newRecord;
                if (updatedChallenge['sender_id'] == user.id) {
                  final index = sentChallenges.indexWhere(
                    (c) => c['id'] == updatedChallenge['id'],
                  );
                  if (index != -1) {
                    sentChallenges[index] = updatedChallenge;
                    notifyListeners();
                  }
                }
              },
            )
            .subscribe();
  }

  Future<void> loadGetChallenge() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("Nicht eingeloggt");

    final response = await _client
        .from('challenges')
        .select('*, sender:sender_id(username, profile_image_url)')
        .eq('sender_id', user.id);

    getChallenges = List<Map<String, dynamic>>.from(response);

    // ➕ GIFs laden
    for (var challenge in getChallenges) {
      final id = challenge['id'].toString();
      final exercise = challenge['exercise'] ?? '';
      if (exercise.isNotEmpty) {
        await fetchGifForChallenge(id, exercise);
      }
    }

    notifyListeners();

    await _sentSubscription?.unsubscribe();
    _sentSubscription = null;

    _sentSubscription =
        _client
            .channel('public:challenges')
            .onPostgresChanges(
              event: PostgresChangeEvent.insert,
              schema: 'public',
              table: 'challenges',
              callback: (payload) {
                final newChallenge = payload.newRecord;
                if (newChallenge['sender_id'] == user.id) {
                  getChallenges.add(newChallenge);
                  notifyListeners();
                }
              },
            )
            .onPostgresChanges(
              event: PostgresChangeEvent.update,
              schema: 'public',
              table: 'challenges',
              callback: (payload) {
                final updatedChallenge = payload.newRecord;
                if (updatedChallenge['sender_id'] == user.id) {
                  final index = getChallenges.indexWhere(
                    (c) => c['id'] == updatedChallenge['id'],
                  );
                  if (index != -1) {
                    getChallenges[index] = updatedChallenge;
                    notifyListeners();
                  }
                }
              },
            )
            .subscribe();
  }

  Future<void> updateChallengeStatus(String id, String newStatus) async {
    await _client
        .from('challenges')
        .update({'challenge_status': newStatus})
        .eq('id', id);

    final index = receivedChallenges.indexWhere((c) => c['id'] == id);
    if (index != -1) {
      receivedChallenges[index]['challenge_status'] = newStatus;
      notifyListeners();
    }

    print(
      "Status der Challenge $id auf $newStatus gesetzt und lokal aktualisiert",
    );
  }

  Future<void> fetchGifForChallenge(String challengeId, String exercise) async {
    const apiKey =
        'b2A0clF4Pm14uszrWwdNOjWB52N6veib'; // am besten später in .env
    final query = Uri.encodeComponent(exercise);
    final url =
        'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&limit=1';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['data'] != null && json['data'].isNotEmpty) {
        final gifUrl = json['data'][0]['images']['original']['url'];
        _gifUrls[challengeId] = gifUrl;
        notifyListeners();
      }
    } else {
      print('❌ Giphy-API Fehler: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _receivedSubscription?.unsubscribe();
    _sentSubscription?.unsubscribe();
    super.dispose();
  }
}
