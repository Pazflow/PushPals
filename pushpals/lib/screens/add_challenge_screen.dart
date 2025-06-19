import 'package:flutter/material.dart';
import 'package:pushpals/widgets/kompletes_app_design_widget.dart';
import 'package:pushpals/widgets/dropdown_card_widget.dart';
import 'package:pushpals/widgets/dropdown_switch_card_widget.dart';

class AddChallengeScreen extends StatelessWidget {
  const AddChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const DropdownSwitchCardWidget(),
            const SizedBox(height: 20),
            const DropdownCardWidget(
              title: 'Zeitlimit',
              dropdownHint: 'Wähle ein Zeitlimit',
            ),
            const SizedBox(height: 20),
            const DropdownCardWidget(
              title: 'Modus',
              dropdownHint: 'Wähle einen Modus',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
