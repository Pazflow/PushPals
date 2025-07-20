import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/proof_image_model.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'package:pushpals/models/profile_setup_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pushpals/widgets/basebutton_widget.dart';
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
  Uint8List? savedProofImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final challengeModel = Provider.of<ChallengeModel>(
        context,
        listen: false,
      );
      final challenge = challengeModel.receivedChallenges.firstWhere(
        (c) => c['id'] == widget.challengeId,
        orElse: () => {},
      );

      if (challenge.isNotEmpty &&
          challenge['challenge_status'] == 'completed') {
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
    final profileModel = Provider.of<ProfileSetupModel>(context, listen: false);

    return ChangeNotifierProvider.value(
      value: widget.proofModel,
      child: Consumer<ProofImageModel>(
        builder: (context, proofModel, _) {
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    final double spacing = 16;
                    final double buttonWidth =
                        (constraints.maxWidth - spacing) / 2;
                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: [
                        _buildProofButton(
                          icon: Icons.photo_camera,
                          label: 'Foto\naufnehmen',
                          width: buttonWidth,
                          onPressed: () async {
                            final userId =
                                Supabase.instance.client.auth.currentUser?.id ??
                                'unknown_user';
                            await proofModel.pickImageAndUpload(
                              userId,
                              widget.challengeId,
                              fromCamera: true,
                            );
                            setState(() {
                              savedProofImage = proofModel.proofImageBytes;
                            });
                          },
                        ),
                        _buildProofButton(
                          icon: Icons.videocam,
                          label: 'Video\naufnehmen',
                          width: buttonWidth,
                          onPressed: () {
                            print("Video aufnehmen gedrückt");
                          },
                        ),
                        _buildProofButton(
                          icon: Icons.image,
                          label: 'Foto\nauswählen',
                          width: buttonWidth,
                          onPressed: () async {
                            final userId =
                                Supabase.instance.client.auth.currentUser?.id ??
                                'unknown_user';
                            await proofModel.pickImageAndUpload(
                              userId,
                              widget.challengeId,
                            );
                            setState(() {
                              savedProofImage = proofModel.proofImageBytes;
                            });
                          },
                        ),
                        _buildProofButton(
                          icon: Icons.video_library,
                          label: 'Video\nauswählen',
                          width: buttonWidth,
                          onPressed: () {
                            print("Video auswählen gedrückt");
                          },
                        ),
                      ],
                    );
                  },
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
                      label:
                          isProofSaved
                              ? 'Challenge beendet'
                              : 'Challenge bestätigen',
                      backgroundColor:
                          isProofSaved ? Colors.green : const Color(0xFFFFC107),
                      foregroundColor:
                          isProofSaved ? Colors.white : Colors.black,
                      onPressed: () async {
                        await challengeModel.updateChallengeStatus(
                          widget.challengeId,
                          'completed',
                          profileModel,
                        );
                        setState(() {
                          isProofSaved = true;
                        });
                        print(
                          'Beweis gespeichert, Challenge auf completed gesetzt!',
                        );
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

  Widget _buildProofButton({
    required IconData icon,
    required String label,
    required double width,
    required VoidCallback onPressed,
  }) {
    final bool block = isProofSaved;
    final Color buttonColor =
        block ? Colors.grey.withOpacity(0.5) : const Color(0xFF2196F3);

    return SizedBox(
      width: width,
      height: 60,
      child: AbsorbPointer(
        absorbing: block,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          label: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),

          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
