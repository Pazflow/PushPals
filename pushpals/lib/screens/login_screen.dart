import 'package:flutter/material.dart';
import 'package:pushpals/widgets/app_design_widget.dart';
import 'package:pushpals/widgets/button_widget.dart';
import 'package:pushpals/widgets/custom_input_field_widget.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDesign(
      title: null,
      showBack: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pushpals',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24),
          ),
          SizedBox(height: 32),
          const CustomInputField(hint: 'E-mail'),
          SizedBox(height: 16),
          const CustomInputField(hint: 'Passwort'),
          SizedBox(height: 25),
          ButtonWidget(onPressed: () {}, label: 'Registrieren'),
          SizedBox(height: 16),
          ButtonWidget(
            //das allgemeine ButtonWidget ist frei zu formen, Standard ist sowie Registrieren, nur das Label ist immer anzugeben
            onPressed: () {},
            label: 'Login',
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            width: 100,
            height: 150,
            borderRadius: 20,
          ),
        ],
      ),
    );
  }
}
