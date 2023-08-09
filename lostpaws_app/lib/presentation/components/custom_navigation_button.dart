import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostpaws_app/business/cubit/authentication_cubit.dart';
import 'package:lostpaws_app/presentation/components/navigation_buttons.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/routes/unauthenticated_locations.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class CustomNavigationButton extends StatelessWidget {
  const CustomNavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: IconButton(
        tooltip: "Settings",
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const SettingsAlertDialog(),
          );
        },
        icon: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const ShapeDecoration(
            color: ConstColors.mediumGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SettingsAlertDialog extends StatelessWidget {
  const SettingsAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ConstColors.lightGreen,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultPadding),
          side: const BorderSide(
            width: 3.0,
            color: ConstColors.darkGreen,
          )),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.chevron_left,
                color: ConstColors.darkOrange,
              ),
              iconSize: 40,
              splashColor: ConstColors.lightOrange,
              splashRadius: defaultPadding,
            ),
          ),
          Text(
            'Settings',
            style: const LostPawsText().primaryTitleBold,
          ),
        ],
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavigationButtons(
                text: "Home",
                icon: Icons.home,
                onTap: () =>
                    Beamer.of(context).beamToNamed(HomeLocations.homeRoute),
              ),
              NavigationButtons(
                text: "Post",
                icon: Icons.note_alt_outlined,
                onTap: () => Beamer.of(context)
                    .beamToNamed(HomeLocations.createPostingRoute),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavigationButtons(
                text: "Map View",
                icon: Icons.assistant_navigation,
                onTap: () =>
                    Beamer.of(context).beamToNamed(HomeLocations.mapViewRoute),
              ),
              NavigationButtons(
                text: "Profile",
                icon: Icons.account_circle_rounded,
                onTap: () =>
                    Beamer.of(context).beamToNamed(HomeLocations.profileRoute),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NavigationButtons(
                text: "Saved Posts",
                icon: Icons.bookmark,
                onTap: () => Beamer.of(context)
                    .beamToNamed(HomeLocations.savedPostsRoute),
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: ConstColors.mediumGreen,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            try {
              final beamer = Beamer.of(context);
              await context.read<AuthenticationCubit>().signOut();
              beamer.beamToNamed(UnauthenticatedLocations.signInRoute);
            } catch (e) {
              print(e);
            }
          },
          child: Text(
            'Logout',
            style: const LostPawsText().primaryRegularWhite,
          ),
        ),
      ],
    );
  }
}
