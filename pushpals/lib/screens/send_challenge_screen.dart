import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushpals/models/challenge_model.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/sended_challenge_widget.dart';

class SendChallengeScreen extends StatefulWidget {
  const SendChallengeScreen({super.key});

  @override
  State<SendChallengeScreen> createState() => _SendChallengeScreenState();
}

class _SendChallengeScreenState extends State<SendChallengeScreen> {
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    final model = Provider.of<ChallengeModel>(context, listen: false);
    _loadFuture = model.loadSentChallenges();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ChallengeModel>(context, listen: true);

    return FutureBuilder(
      future: _loadFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Fehler: ${snapshot.error}')),
          );
        }

        return AppDesign(
          showBack: true,
          showProfile: true,
          title: 'zum Duell herausgefordert',
          selectedIndex: 3,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  model.sentChallenges.map((challenge) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SendenChallengeWidget(challengeData: challenge),
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }
}
