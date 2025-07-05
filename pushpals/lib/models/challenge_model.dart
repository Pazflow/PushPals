import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChallengeModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  String? selectedExercise;
  String? receiverId;
  String? timeLimit;
  int? repetitions;

  List<Map<String, dynamic>> receivedChallenges = [];
  RealtimeChannel? _subscription;

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
      'challenge_status': 'pending', // Standard-Status
    };

    await _client.from('challenges').insert(challengeData);
    print('Challenge erfolgreich gespeichert: $challengeData');
  }

  Future<void> loadReceivedChallenges() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("Nicht eingeloggt");

    // Einmal initial laden
    final response = await _client
        .from('challenges')
        .select('*, sender:sender_id(username, profile_image_url)')
        .eq('receiver_id', user.id);

    receivedChallenges = List<Map<String, dynamic>>.from(response);
    notifyListeners();

    // Alte Subscription beenden, falls vorhanden
    if (_subscription != null) {
      await _client.removeChannel(_subscription!);
    }

    // Neue Realtime Subscription starten
    _subscription =
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

  Future<void> updateChallengeStatus(String id, String newStatus) async {
    await _client
        .from('challenges')
        .update({'challenge_status': newStatus})
        .eq('id', id);
    print("Status der Challenge $id auf $newStatus gesetzt");
  }

  @override
  void dispose() {
    if (_subscription != null) {
      _client.removeChannel(_subscription!);
    }
    super.dispose();
  }
}
