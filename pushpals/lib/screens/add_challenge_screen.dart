import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/widgets/basebutton_widget.dart';
import 'package:pushpals/widgets/app_design_own_widget.dart';
import 'package:pushpals/widgets/dropdown_card_widget.dart';
import 'package:pushpals/widgets/dropdown_switch_card_widget.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'package:pushpals/services/friend_service.dart';
import 'package:pushpals/models/friend_model.dart';

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
  final List<String> exerciseOptions = [
    'Liegestütze',
    'Kniebeugen',
    'Sit-ups',
    'Hampelmann',
    'Känguru-Hüpfer',
  ];

  bool isCustomTime = false;
  String? selectedTimeLimit;
  final TextEditingController customTimeController = TextEditingController();
  final List<String> timeOptions = ['30min', '2h', '24h', '7 Tage', '30 Tage'];

  bool isCustomRepetitions = false;
  String? selectedRepetitions;
  final TextEditingController customRepetitionsController =
      TextEditingController();
  final List<String> repetitionOptions = ['10', '20', '50', '100'];

  List<Friend> friends = [];
  Friend? selectedFriend;
  bool isLoadingFriends = true;

  @override
  void initState() {
    super.initState();
    loadFriends();
  }

  Future<void> loadFriends() async {
    final service = FriendService();
    final fetchedFriends = await service.fetchFriends();

    final uniqueFriends = <String, Friend>{};
    for (var friend in fetchedFriends) {
      uniqueFriends[friend.id] = friend;
    }

    setState(() {
      friends = uniqueFriends.values.toList();
      isLoadingFriends = false;
    });
  }

  @override
  void dispose() {
    customExerciseController.dispose();
    customTimeController.dispose();
    customRepetitionsController.dispose();
    super.dispose();
  }

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
            ButtonWidget(
              onPressed: () {
                GoRouter.of(context).go('/freund_einladen');
              },
              label: 'Freund einladen',
            ),
            const SizedBox(height: 20),

            isLoadingFriends
                ? const Center(child: CircularProgressIndicator())
                : DropdownCardWidget(
                  title: 'Freund auswählen',
                  dropdownHint: 'Wähle einen Freund',
                  items:
                      friends.map((f) {
                        return {'id': f.id, 'label': f.username};
                      }).toList(),
                  selectedValue: selectedFriend?.id,
                  onChanged: (value) {
                    final chosenFriend = friends.firstWhere(
                      (f) => f.id == value,
                    );
                    setState(() {
                      selectedFriend = chosenFriend;
                    });
                    challengeModel.setReceiverId(chosenFriend.id);
                    print('Receiver ID gesetzt: ${chosenFriend.id}');
                  },
                ),
            const SizedBox(height: 20),

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
              customHint: 'Eigene Challenge festlegen',
              switchLabel: 'Eigene Challenge definieren',
            ),
            const SizedBox(height: 20),

            DropdownSwitchCardWidget(
              title: 'Zeitlimit auswählen',
              dropdownHint: 'Zeitlimit wählen',
              items: timeOptions,
              selectedValue: selectedTimeLimit,
              isCustom: isCustomTime,
              customInputController: customTimeController,
              onDropdownChanged: (value) {
                setState(() {
                  selectedTimeLimit = value;
                  challengeModel.setTimeLimit(value!);
                });
              },
              onCustomInputChanged: (value) {
                challengeModel.setTimeLimit(value);
              },
              onSwitchChanged: (value) {
                setState(() {
                  isCustomTime = value;
                  if (value) {
                    selectedTimeLimit = null;
                  } else {
                    customTimeController.clear();
                  }
                });
              },
              customHint: 'Eigenes Zeitlimit festlegen',
              switchLabel: 'Eigenes Zeitlimit definieren',
            ),
            const SizedBox(height: 20),

            DropdownSwitchCardWidget(
              title: 'Wiederholungen',
              dropdownHint: 'Anzahl wählen',
              items: repetitionOptions,
              selectedValue: selectedRepetitions,
              isCustom: isCustomRepetitions,
              customInputController: customRepetitionsController,
              onDropdownChanged: (value) {
                setState(() {
                  selectedRepetitions = value;
                  challengeModel.setRepetitions(value!);
                });
              },
              onCustomInputChanged: (value) {
                challengeModel.setRepetitions(value);
              },
              onSwitchChanged: (value) {
                setState(() {
                  isCustomRepetitions = value;
                  if (value) {
                    selectedRepetitions = null;
                  } else {
                    customRepetitionsController.clear();
                  }
                });
              },
              customHint: 'Eigene Anzahl der Wiederholungen',
              switchLabel: 'Eigene Anzahl definieren',
            ),
            const SizedBox(height: 30),

            ButtonWidget(
              label: 'Challenge speichern',
              onPressed: () async {
                if (challengeModel.receiverId == null ||
                    challengeModel.receiverId!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bitte wähle einen Freund aus!'),
                    ),
                  );
                  return;
                }

                try {
                  await challengeModel.submitChallenge();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Challenge gespeichert!')),
                    );
                    context.go('/home');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Fehler: $e')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
