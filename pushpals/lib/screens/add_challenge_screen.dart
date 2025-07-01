import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pushpals/widgets/button_allg_widget.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/dropdown_card_widget.dart';
import 'package:pushpals/widgets/dropdown_switch_card_widget.dart';
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
            // Freund Dropdown
            DropdownCardWidget(
              title: 'Freund auswählen',
              dropdownHint: 'Wähle einen Freund',
              items: ['Max', 'Anna', 'Tom'], // TODO: dynamisch laden später
              onChanged: (value) {
                // TODO: Freund setzen
              },
            ),
            const SizedBox(height: 20),

            // Übung + Eigene Challenge Switch
            DropdownSwitchCardWidget(
              title: 'Übung auswählen',
              dropdownHint: 'Übung wählen',
              items: exerciseOptions,
              selectedValue: selectedExercise,
              isCustom: isCustomExercise,
              customInputController: customExerciseController,
              onDropdownChanged: (value) {
                setState(() {
                  selectedExercise = value;
                  challengeModel.setExercise(value!);
                });
              },
              onCustomInputChanged: (value) {
                challengeModel.setExercise(value);
              },
              onSwitchChanged: (value) {
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
            const SizedBox(height: 20),

            // Zeitlimit
            DropdownCardWidget(
              title: 'Zeitlimit auswählen',
              dropdownHint: 'Zeitlimit',
              items: timeOptions,
              onChanged: (value) {
                selectedTimeLimit = value;
                challengeModel.setTimeLimit(value!);
              },
            ),
            const SizedBox(height: 20),

            // Wiederholungen
            DropdownCardWidget(
              title: 'Wiederholungen',
              dropdownHint: 'Anzahl auswählen',
              items: repetitionOptions,
              onChanged: (value) {
                selectedRepetitions = value;
                challengeModel.setRepetitions(value!);
              },
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
}
