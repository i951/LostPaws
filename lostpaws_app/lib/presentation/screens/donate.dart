import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/components/custom_app_bar.dart';
import 'package:lostpaws_app/presentation/components/custom_bottom_nav_bar.dart';
import 'package:lostpaws_app/presentation/components/info_card.dart';
import 'package:lostpaws_app/presentation/components/posting_preview.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class DonationScreen extends extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Here'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/heart_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Donate Here',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'The BCSPCA is a charity organization dedicated to protecting and enhancing the quality of life for domestic, farm, and wild animals in British Columbia. Your donation will help us continue our important work in animal welfare.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String donationLink = 'https://spca.bc.ca/donations/make-a-donation/?utm_source=header&utm_campaign=donate';
                },
                child: Text('Donate Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}