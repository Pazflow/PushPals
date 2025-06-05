import 'package:flutter/material.dart';

class BeweisCardWidget extends StatelessWidget {
  final String title;
  final String btnPhotoCapture;
  final String btnVideoCapture;
  final String btnPhotoSelect;
  final String btnVideoSelect;

  const BeweisCardWidget({
    super.key,
    this.title = 'Beweis hochladen',
    this.btnPhotoCapture = 'Foto aufnehmen',
    this.btnVideoCapture = 'Video aufnehmen',
    this.btnPhotoSelect = 'Foto auswählen',
    this.btnVideoSelect = 'Video auswählen',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
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
                    child: _buildButton(Icons.photo_camera, btnPhotoCapture),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildButton(Icons.videocam, btnVideoCapture),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildButton(Icons.image, btnPhotoSelect)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildButton(Icons.video_library, btnVideoSelect),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {}, // Nur Layout
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
