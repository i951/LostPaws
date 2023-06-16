import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/components/custom_navigation_button.dart';
import 'package:lostpaws_app/presentation/components/navigation_buttons.dart';
import 'package:lostpaws_app/presentation/constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        width: 500,
        color: ConstColors.lightGreen,
        child: const CustomNavigationButton(),
      ),
    );
  }
}
