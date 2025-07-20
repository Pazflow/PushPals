import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'package:pushpals/models/profile_setup_model.dart';
import 'package:pushpals/widgets/app_design_own_widget.dart';
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
    final profileModel = Provider.of<ProfileSetupModel>(context, listen: false);

    return AppDesign(
      showBack: false,
      showProfile: true,
      title: 'PushPals - meine Challenges',
      selectedIndex: 0,
      child:
          challengeModel.receivedChallenges.isEmpty
              ? const Center(child: Text('Keine Challenges erhalten'))
              : ListView.builder(
                itemCount: challengeModel.receivedChallenges.length,
                itemBuilder: (context, index) {
                  final challenge = challengeModel.receivedChallenges[index];
                  final statusString =
                      challenge['challenge_status'] ?? 'pending';
                  final status = convertStatusStringToEnum(statusString);
                  final gifUrl =
                      challengeModel.gifUrls[challenge['id'].toString()] ??
                      ''; 

                  return GestureDetector(
                    onTap: () async {
                      final challengeModel = Provider.of<ChallengeModel>(
                        context,
                        listen: false,
                      );
                      final status = challenge['challenge_status'];

                      if (status != 'accepted' && status != 'completed') {
                        if (status == 'failed') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Details? Dazu hättest du dich trauen sollen.',
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Zuerst annehmen, wenn du Details sehen willst.',
                              ),
                            ),
                          );
                        }
                        return;
                      }

                      challengeModel.setSelectedChallenge(challenge);

                      if (!challengeModel.gifUrls.containsKey(
                        challenge['id'].toString(),
                      )) {
                        await challengeModel.fetchGifForChallenge(
                          challenge['id'].toString(),
                          challenge['exercise'] ?? '',
                        );
                      }

                      context.push('/challenge_details');
                    },
                    child: ChallengeCard(
                      titleText:
                          'Challenge von ${challenge['sender']?['username'] ?? 'Unbekannt'}',
                      challengeText: challenge['exercise'] ?? 'Übung',
                      imagePath:
                          (challenge['sender']?['profile_image_url'] != null &&
                                  challenge['sender']!['profile_image_url']
                                      .toString()
                                      .isNotEmpty)
                              ? challenge['sender']!['profile_image_url']
                              : 'assets/images/IT_Nerd.png',

                      status: status,
                      gifUrl: gifUrl, 
                      onAccept: () async {
                        await Provider.of<ChallengeModel>(
                          context,
                          listen: false,
                        ).updateChallengeStatus(
                          challenge['id'].toString(),
                          'accepted',
                          profileModel,
                        );
                      },
                      onDecline: () async {
                        await Provider.of<ChallengeModel>(
                          context,
                          listen: false,
                        ).updateChallengeStatus(
                          challenge['id'].toString(),
                          'failed',
                          profileModel,
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
