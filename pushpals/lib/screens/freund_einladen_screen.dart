import 'package:flutter/material.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/freunde_einladen_card_widget.dart';
import 'package:pushpals/widgets/freund_card_widget.dart';
import 'package:pushpals/widgets/freunde_anfragen_dynamisch_widget.dart';

class FriendSearchScreen extends StatelessWidget {
  const FriendSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Freund einladen',
      selectedIndex: 0,

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FriendSearchCard(),
            SizedBox(height: 20),
            FriendRequestListWidget(),
            SizedBox(height: 20),
            FriendTile(
              name: 'Nutzi',
              subtitle: 'Friend',
              imagePath: '../assets/images/IT_Nerd.png',
              backgroundcolor: Colors.red,
              onDelete: () {},
            ),
            SizedBox(height: 5),
            FriendTile(
              name: 'Nutzi',
              subtitle: 'Friend',
              imagePath: '../assets/images/IT_Nerd.png',
              onDelete: () {},
            ),
            SizedBox(height: 5),
            FriendTile(
              name: 'Nutzi',
              subtitle: 'Friend',
              imagePath: '../assets/images/IT_Nerd.png',
              backgroundcolor: Colors.yellow,
              onDelete: () {},
            ),
            FriendTile(
              name: 'Nutzi',
              subtitle: 'Friend',
              imagePath: '../assets/images/IT_Nerd.png',
              backgroundcolor: const Color(0xFF28271E),
              onDelete: () {},
            ),
            FriendTile(
              name: 'Nutzi',
              subtitle: 'Friend',
              imagePath: '../assets/images/IT_Nerd.png',
              backgroundcolor: const Color(0xFF207A8A),
              onDelete: () {},
            ),
          ],
        ),
      ),
    );
  }
}
