import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class NavigationButtons extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  const NavigationButtons({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        child: Container(
          height: getProportionateScreenHeight(80),
          width: getProportionateScreenWidth(100),
          decoration: BoxDecoration(
            color: ConstColors.babyBlue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(10.5),
            border: Border.all(
              color: ConstColors.darkOrange,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: ConstColors.mediumGreen,
                  size: getProportionateScreenWidth(defaultPadding),
                ),
              ),
              Text(
                text,
                style: const LostPawsText().primarySemiBoldGreen,
              )
            ],
          ),
        ),
      ),
    );
  }
}
