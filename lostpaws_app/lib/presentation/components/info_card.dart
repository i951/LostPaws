// Flutter imports:
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

/// A light red box with a red warning sign and red warning title.
///
/// Returns a 0x0 [SizedBox] if title is null or empty, under the assumption that
/// there is no error.
class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    this.title,
    this.text,
    required this.routeName,
  });

  final String? title;
  final String? text;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    if (title == null || title!.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    return InkWell(
      onTap: () =>
          Beamer.of(context).beamToNamed(HomeLocations.createPostingRoute),
      child: Container(
        width: getProportionateScreenWidth(350),
        margin: EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            color: ConstColors.babyBlue,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            const SizedBox.square(
              dimension: 40.0,
              child: Icon(
                Icons.info,
                size: 30.0,
                color: ConstColors.darkOrange,
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: Theme.of(context)
                        .extension<LostPawsText>()!
                        .primarySemiBold
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    text!,
                    style: Theme.of(context)
                        .extension<LostPawsText>()!
                        .primaryRegular
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 30.0,
              color: ConstColors.mediumGreen,
            ),
          ],
        ),
      ),
    );
  }
}
