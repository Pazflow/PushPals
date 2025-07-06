import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/proof_image_model.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pushpals/widgets/button_allg_widget.dart';
import 'dart:typed_data';


class BeweisCardWidget extends StatefulWidget {
  final String challengeId;
  final ProofImageModel proofModel;

  const BeweisCardWidget({
    super.key,
    required this.challengeId,
    required this.proofModel,
  });

  @override
  State<BeweisCardWidget> createState() => _BeweisCardWidgetState();
}

class _BeweisCardWidgetState extends State<BeweisCardWidget> {
  bool isProofSaved = false;
  Uint8List? savedProofImage; // <-- lokale Kopie vom Bild

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final challengeModel = Provider.of<ChallengeModel>(context, listen: false);
      final challenge = challengeModel.receivedChallenges.firstWhere(
        (c) => c['id'] == widget.challengeId,
        orElse: () => {},
      );

      if (challenge.isNotEmpty && challenge['challenge_status'] == 'completed') {
        setState(() {
          isProofSaved = true;
          savedProofImage = widget.proofModel.proofImageBytes;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final challengeModel = Provider.of<ChallengeModel>(context, listen: false);

    return ChangeNotifierProvider.value(
      value: widget.proofModel,
      child: Consumer<ProofImageModel>(
        builder: (context, proofModel, _) {
          // Prüfen und speichern, falls Bild vorhanden und noch nicht gespeichert
          if (proofModel.proofImageBytes != null && savedProofImage == null) {
            savedProofImage = proofModel.proofImageBytes;
          }

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF06101F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Beweis hochladen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildButton(
                            Icons.photo_camera,
                            'Foto aufnehmen',
                            () {
                              print("Foto aufnehmen gedrückt");
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildButton(
                            Icons.videocam,
                            'Video aufnehmen',
                            () {
                              print("Video aufnehmen gedrückt");
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildButton(
                            Icons.image,
                            'Foto auswählen',
                            () async {
                              final userId = Supabase.instance.client.auth.currentUser?.id ?? 'unknown_user';
                              await proofModel.pickImageAndUpload(
                                userId,
                                widget.challengeId,
                              );
                              setState(() {
                                savedProofImage = proofModel.proofImageBytes;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildButton(
                            Icons.video_library,
                            'Video auswählen',
                            () {
                              print("Video auswählen gedrückt");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (savedProofImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Image.memory(savedProofImage!),
                  ),
                const SizedBox(height: 16),
                if (savedProofImage != null)
                  AbsorbPointer(
                    absorbing: isProofSaved,
                    child: ButtonWidget(
                      label: isProofSaved ? 'Challenge beendet' : 'Challenge bestätigen',
                      backgroundColor: isProofSaved ? Colors.green : const Color(0xFFFFC107),
                      foregroundColor: isProofSaved ? Colors.white : Colors.black,
                      onPressed: () async {
                        await challengeModel.updateChallengeStatus(widget.challengeId, 'completed');
                        setState(() {
                          isProofSaved = true;
                        });
                        print('Beweis gespeichert, Challenge auf completed gesetzt!');
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton(
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    final bool block = isProofSaved;
    final Color buttonColor = block ? Colors.grey.withOpacity(0.5) : const Color(0xFF2196F3);

    return AbsorbPointer(
      absorbing: block,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
