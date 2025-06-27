import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FriendSearchCard extends StatefulWidget {
  const FriendSearchCard({super.key});

  @override
  State<FriendSearchCard> createState() => _FriendSearchCardState();
}

class _FriendSearchCardState extends State<FriendSearchCard> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendFriendRequest() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final currentUser = Supabase.instance.client.auth.currentUser;

      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Benutzer nicht eingeloggt.')),
        );
        setState(() => _isLoading = false);
        return;
      }

      final currentUserId = currentUser.id;
      final senderEmail = currentUser.email ?? 'Unbekannt';

      print('== SENDER-ID: $currentUserId');
      print('== SENDER-EMAIL: $senderEmail');

      final user = await Supabase.instance.client
          .from('users')
          .select('id')
          .eq('email', email)
          .maybeSingle();

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kein Nutzer mit dieser E-Mail gefunden.'),
          ),
        );
        setState(() => _isLoading = false);
        return;
      }

      final receiverId = user['id'];

      if (receiverId == currentUserId) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Du kannst dir selbst keine Anfrage senden.'),
          ),
        );
        setState(() => _isLoading = false);
        return;
      }

      final existingRequest = await Supabase.instance.client
          .from('friend_requests')
          .select()
          .match({
            'sender_id': currentUserId,
            'receiver_id': receiverId,
            'status': 'pending',
          })
          .maybeSingle();

      if (existingRequest != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Anfrage wurde bereits gesendet.')),
        );
        setState(() => _isLoading = false);
        return;
      }

      // 👉 Jetzt korrektes INSERT mit Name
      await Supabase.instance.client.from('friend_requests').insert({
        'sender_id': currentUserId,
        'receiver_id': receiverId,
        'status': 'pending',
        'sender_name': senderEmail,
      });

      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Einladung gesendet'),
          content: Text(
            'Die Einladung an $email wurde erfolgreich erstellt.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _emailController.clear();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Fehler: ${e.toString()}')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2E2E2E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Freunde finden',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email, color: Colors.white),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () => _emailController.clear(),
                ),
                hintText: 'E-Mail eingeben',
                hintStyle: const TextStyle(color: Colors.white60),
                filled: true,
                fillColor: const Color(0xFF424242),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Gib die E-Mail-Adresse des Freundes ein',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _sendFriendRequest,
                icon: const Icon(Icons.person_add, color: Colors.white),
                label: _isLoading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Freund hinzufügen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
