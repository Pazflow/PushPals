import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChallengeModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  String? selectedExercise;
  String? receiverId;
  String? timeLimit;
  int? repetitions;

  List<Map<String, dynamic>> receivedChallenges = [];
  List<Map<String, dynamic>> sentChallenges = [];

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
    print("Alle gesendeten Challenges (Model): $sentChallenges");
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

  @override
  void dispose() {
    _receivedSubscription?.unsubscribe();
    _sentSubscription?.unsubscribe();
    super.dispose();
  }
}
