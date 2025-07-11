import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/challange_card_widget.dart';
import 'package:pushpals/enums/enum_challenge_status.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChallengeModel>(
        context,
        listen: false,
      ).loadReceivedChallenges();
    });
  }

  @override
  Widget build(BuildContext context) {
    final challengeModel = Provider.of<ChallengeModel>(context);

    return AppDesign(
      showBack: false,
      showProfile: true,
      title: 'PushPals - meine Challenges',
      selectedIndex: 0,
      child:
          challengeModel.receivedChallenges.isEmpty
              ? const Center(child: Text('Keine Challenges erhalten'))
              : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: challengeModel.receivedChallenges.length,
                itemBuilder: (context, index) {
                  final challenge = challengeModel.receivedChallenges[index];
                  final statusString =
                      challenge['challenge_status'] ?? 'pending';
                  final status = convertStatusStringToEnum(statusString);

                  return GestureDetector(
                    onTap: () {
                      Provider.of<ChallengeModel>(
                        context,
                        listen: false,
                      ).setSelectedChallenge(challenge);

                      context.push('/challenge_details');
                    },
                    child: ChallengeCard(
                      titleText:
                          'Challenge von ${challenge['sender']?['username'] ?? 'Unbekannt'}',
                      challengeText: challenge['exercise'] ?? 'Übung',
                      imagePath:
                          challenge['sender']?['profile_image_url'] ??
                          'assets/images/IT_Nerd.png',
                      status: status,
                      onAccept: () async {
                        await Provider.of<ChallengeModel>(
                          context,
                          listen: false,
                        ).updateChallengeStatus(
                          challenge['id'].toString(),
                          'accepted',
                        );
                      },
                      onDecline: () async {
                        await Provider.of<ChallengeModel>(
                          context,
                          listen: false,
                        ).updateChallengeStatus(
                          challenge['id'].toString(),
                          'failed',
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
