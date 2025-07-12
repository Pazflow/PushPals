import 'package:flutter/material.dart';
import 'package:pushpals/widgets/eingabe_feld_widget.dart';

class DropdownSwitchCardWidget extends StatelessWidget {
  final String title;
  final String dropdownHint;
  final List<String> items;
  final String? selectedValue;
  final bool isCustom;
  final ValueChanged<String?>? onDropdownChanged;
  final ValueChanged<bool>? onSwitchChanged;
  final ValueChanged<String>? onCustomInputChanged;
  final TextEditingController? customInputController;
  final String customHint;
  final String switchLabel;

  const DropdownSwitchCardWidget({
    super.key,
    required this.title,
    required this.dropdownHint,
    required this.items,
    this.selectedValue,
    this.isCustom = false,
    this.onDropdownChanged,
    this.onSwitchChanged,
    this.onCustomInputChanged,
    this.customInputController,
    required this.customHint,
    required this.switchLabel,
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

            if (!isCustom)
              DropdownButtonFormField<String>(
                value: selectedValue,
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
                items:
                    items
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: onDropdownChanged,
              ),

            if (isCustom)
              CustomInputField(
                hint: customHint,
                controller: customInputController,
                onChanged: onCustomInputChanged,
              ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  switchLabel,
                  style: const TextStyle(color: Colors.white70),
                ),
                Switch(
                  value: isCustom,
                  onChanged: onSwitchChanged,
                  activeColor: const Color(0xFF0084FF),
                  activeTrackColor: const Color(0xFFB2F2BB),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFF3B0202),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
