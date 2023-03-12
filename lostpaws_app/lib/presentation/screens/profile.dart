import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/components/custom_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      body: Center(
        child: Text("This is the profile page"),
      ),
    );
  }
}
