import 'package:flutter/material.dart';
import 'package:pushpals/widgets/app_design_own_widget.dart';
import 'package:pushpals/widgets/invite_friend_card_widget.dart';

class FriendSearchScreen extends StatefulWidget {
  const FriendSearchScreen({super.key});

  @override
  State<FriendSearchScreen> createState() => _FriendSearchScreenState();
}

class _FriendSearchScreenState extends State<FriendSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: 'Freund einladen',
      selectedIndex: 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            FriendSearchCard(),
          ],
        ),
      ),
    );
  }
}
