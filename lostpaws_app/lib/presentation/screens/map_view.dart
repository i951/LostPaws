import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarOpacity: 1.0,
        toolbarHeight: getProportionateScreenHeight(80),
        backgroundColor: ConstColors.mediumGreen,
        foregroundColor: ConstColors.darkOrange,
        leading: IconButton(
          iconSize: 30.0,
          onPressed: () =>
              Beamer.of(context).beamToNamed(HomeLocations.homeRoute),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
              horizontal: getProportionateScreenWidth(20),
            ),
            decoration: const ShapeDecoration(
              color: ConstColors.lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
            ),
            child: Image.asset('assets/images/map.png'),
          ),
        ),
      ),
    );
  }
}
