import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pushpals/screens/home_screen.dart';
import 'package:pushpals/widgets/button_allg_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/dropdown_card_widget.dart';
import 'package:pushpals/widgets/eingabe_feld_widget.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'package:provider/provider.dart';

class AddChallengeScreen extends StatefulWidget {
  const AddChallengeScreen({super.key});

  @override
  State<AddChallengeScreen> createState() => _AddChallengeScreenState();
}

class _AddChallengeScreenState extends State<AddChallengeScreen> {
  bool isCustomExercise = false;
  String? selectedExercise;
  final TextEditingController customExerciseController =
      TextEditingController();
  final List<String> exerciseOptions = ['Liegestütze', 'Kniebeugen', 'Sit-ups'];

  String? selectedTimeLimit;
  final List<String> timeOptions = ['24h', '7 Tage', '30 Tage'];

  String? selectedRepetitions;
  final List<String> repetitionOptions = ['10', '20', '50', '100'];

  @override
  Widget build(BuildContext context) {
    final challengeModel = Provider.of<ChallengeModel>(context);

    return AppDesign(
      title: 'Challenge erstellen',
      selectedIndex: 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DropdownCardWidget(
              title: 'Freund auswählen',
              dropdownHint: 'Wähle einen Freund',
            ),
            const SizedBox(height: 20),

            // Challenge Auswahl + eigener Input
            Text(
              'Übung auswählen',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (!isCustomExercise)
              DropdownButtonFormField<String>(
                decoration: _dropdownStyle(),
                items:
                    exerciseOptions
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedExercise = value;
                    challengeModel.setExercise(value!);
                  });
                },
                hint: const Text(
                  'Übung wählen',
                  style: TextStyle(color: Colors.white70),
                ),
              ),

            if (isCustomExercise)
              CustomInputField(
                hint: 'Eigene Übung eingeben',
                controller: customExerciseController,
                onChanged: (value) => challengeModel.setExercise(value),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Eigene Challenge definieren',
                  style: TextStyle(color: Colors.white70),
                ),
                Switch(
                  value: isCustomExercise,
                  onChanged: (value) {
                    setState(() {
                      isCustomExercise = value;
                      if (value) {
                        selectedExercise = null;
                      } else {
                        customExerciseController.clear();
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Zeitlimit
            Text(
              'Zeitlimit auswählen',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: _dropdownStyle(),
              items:
                  timeOptions
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                selectedTimeLimit = value;
                challengeModel.setTimeLimit(value!);
              },
              hint: const Text(
                'Zeitlimit',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 20),

            // Wiederholungen
            Text(
              'Wiederholungen',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: _dropdownStyle(),
              items:
                  repetitionOptions
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                selectedRepetitions = value;
                challengeModel.setRepetitions(value!);
              },
              hint: const Text(
                'Anzahl auswählen',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 30),

            // Absende-Button
            ButtonWidget(
              label: 'Challenge speichern',
              onPressed: () async {
                await challengeModel.submitChallenge();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Challenge gespeichert!')),
                  );
                  context.go('/home');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dropdownStyle() => InputDecoration(
    filled: true,
    fillColor: const Color(0xFF06101F),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blue),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blue),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
