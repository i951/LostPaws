import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostpaws_app/business/cubit/authentication_cubit.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/unauthenticated_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = getProportionateScreenHeight(70);

  CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarOpacity: 1.0,
      toolbarHeight: getProportionateScreenHeight(80),
      backgroundColor: ConstColors.mediumGreen,
      foregroundColor: ConstColors.darkOrange,
      actions: [
        IconButton(
          iconSize: 30.0,
          onPressed: () => print("go to search"),
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
