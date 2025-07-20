import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FriendRequestListWidget extends StatefulWidget {
  final Future<void> Function()? onActionCompleted;

  const FriendRequestListWidget({super.key, this.onActionCompleted});

  @override
  State<FriendRequestListWidget> createState() =>
      _FriendRequestListWidgetState();
}

class _FriendRequestListWidgetState extends State<FriendRequestListWidget> {
  late final SupabaseClient _supabase;
  List<Map<String, dynamic>> _requests = [];
  bool _initialLoading = true;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _supabase = Supabase.instance.client;
    _fetchRequests();
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _fetchRequests(),
    );
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchRequests() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final data = await _supabase
          .from('friend_requests')
          .select('id, sender_id, sender_name, status')
          .eq('receiver_id', userId)
          .eq('status', 'pending');

      setState(() {
        _requests = List<Map<String, dynamic>>.from(data);
        _initialLoading = false;
      });
    } catch (e) {
      debugPrint('Fehler beim Laden der Anfragen: $e');
    }
  }

  Future<void> _handleAction(
    String requestId,
    String action,
    String senderId,
  ) async {
    final currentUserId = _supabase.auth.currentUser!.id;
    final fixedRequestId = requestId.trim();

    try {
      final updatedList = await _supabase
          .from('friend_requests')
          .update({'status': action})
          .eq('id', fixedRequestId)
          .select('*');

      if (updatedList.isEmpty) {
        debugPrint('⚠️ Keine Zeilen aktualisiert!');
        return;
      }

      if (action == 'accepted') {
        await _supabase.from('friends').insert([
          {'user_id': currentUserId, 'friend_id': senderId},
          {'user_id': senderId, 'friend_id': currentUserId},
        ]);
      }

      setState(() {
        _requests.removeWhere((r) => r['id'] == fixedRequestId);
      });

      // 👉 HIER: Jetzt _loadFriends aufrufen
      if (widget.onActionCompleted != null) {
        await widget.onActionCompleted!();
      }

      await _fetchRequests();
    } catch (e) {
      debugPrint('❌ Fehler beim Annehmen/Ablehnen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialLoading && _requests.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_requests.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Keine ausstehenden Anfragen vorhanden.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Column(
      children:
          _requests.map((req) {
            final senderName = req['sender_name'] ?? 'Unbekannt';
            return Card(
              color: const Color(0xFF2E2E2E),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: ListTile(
                title: Text(
                  senderName,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'Möchte dein Freund sein',
                  style: TextStyle(color: Colors.white54),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed:
                          () => _handleAction(
                            req['id'],
                            'accepted',
                            req['sender_id'],
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed:
                          () => _handleAction(
                            req['id'],
                            'declined',
                            req['sender_id'],
                          ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
