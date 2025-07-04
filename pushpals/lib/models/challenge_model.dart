import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChallengeModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  String? selectedExercise;
  String? receiverId;
  String? timeLimit;
  int? repetitions;

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
    };

    await _client.from('challenges').insert(challengeData);
    print('Challenge erfolgreich gespeichert: $challengeData');
  }
}
