import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/size_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return const Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Center(child: Text("This is the home page")),
    );
  }
}
