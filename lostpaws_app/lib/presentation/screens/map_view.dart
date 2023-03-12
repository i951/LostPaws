import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/size_config.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    throw UnimplementedError();
    // TODO: see home screen for example
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   resizeToAvoidBottomInset: false,
    //   body: SafeArea(
    //     bottom: false,
    //     child: Container(
    //       decoration: const ShapeDecoration(
    //         color: ConstColors.lightGreen,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    //         ),
    //       ),
    // )
  }
}
