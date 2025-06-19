import 'package:flutter/material.dart';

class DropdownCardWidget extends StatelessWidget {
  final String title;
  final String dropdownHint;
  final List<String> items;

  const DropdownCardWidget({
    super.key,
    this.title = 'Challenge auswählen',
    this.dropdownHint = 'Übung auswählen',
    this.items = const ['Beispiel 1', 'Beispiel 2', 'Beispiel 3'],
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF06101F),
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
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF06101F),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF0084FF)),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF0084FF)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              dropdownColor: const Color(0xFF06101F),
              iconEnabledColor: Colors.white,
              hint: Text(
                dropdownHint,
                style: const TextStyle(color: Colors.white70),
              ),
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child:
                            Text(item, style: const TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (_) {}, // nur Layout
            ),
          ],
        ),
      ),
    );
  }
}
