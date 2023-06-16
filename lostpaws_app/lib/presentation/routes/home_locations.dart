// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:beamer/beamer.dart';
import 'package:lostpaws_app/presentation/routes/lostpaws_beam_page.dart';
import 'package:lostpaws_app/presentation/screens/charity.dart';
import 'package:lostpaws_app/presentation/screens/create_posting.dart';
import 'package:lostpaws_app/presentation/screens/home.dart';
import 'package:lostpaws_app/presentation/screens/map_view.dart';
import 'package:lostpaws_app/presentation/screens/privacy_policy.dart';
import 'package:lostpaws_app/presentation/screens/profile.dart';
import 'package:lostpaws_app/presentation/screens/saved_posts.dart';
import 'package:lostpaws_app/presentation/screens/terms_and_conditions.dart';
import 'package:lostpaws_app/presentation/screens/view_full_posting.dart';

class HomeLocations extends BeamLocation<BeamState> {
  /// beamToNamed location for the [HomeScreen]
  static const String homeRoute = '/home';

  /// beamToNamed location for the [CreatePostingScreen]
  static const String createPostingRoute = '/create_posting';

  /// beamToNamed location for the [ViewFullPostingScreen]
  static const String viewFullPostingRoute = '/view_full_posting';

  /// beamToNamed location for the [MapViewScreen]
  static const String mapViewRoute = '/map_view';

  /// beamToNamed location for the [ProfileScreen]
  static const String profileRoute = '/profile';

  /// beamToNamed location for the [SavedPostsScreen]
  static const String savedPostsRoute = '/saved_posts';

  /// beamToNamed location for the [CharityScreen]
  static const String charityRoute = '/charity';

  /// beamToNamed location for the [TermsAndConditionsScreen]
  static const String termsAndConditionsRoute = '/terms_and_conditions';

  /// beamToNamed location for the [PrivacyPolicyScreen]
  static const String privacyPolicyRoute = '/privacy_policy';

  @override
  List<Pattern> get pathPatterns => _pathPatterns;

  static const List<Pattern> _pathPatterns = [
    //Routes with no nested navigators can be added by path directly:
    homeRoute,
    createPostingRoute,
    viewFullPostingRoute,
    mapViewRoute,
    profileRoute,
    savedPostsRoute,
    charityRoute,
    termsAndConditionsRoute,
    privacyPolicyRoute,
  ];

  @override
  List<LostPawsBeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      LostPawsBeamPage(
        path: homeRoute,
        popToNamed: null,
        child: const HomeScreen(),
      ),
      if (state.uri.path == createPostingRoute) ...[
        LostPawsBeamPage(
          path: createPostingRoute,
          popToNamed: createPostingRoute,
          child: const CreatePostingScreen(),
        )
      ],
      if (state.uri.path == viewFullPostingRoute) ...[
        LostPawsBeamPage(
          path: viewFullPostingRoute,
          popToNamed: homeRoute,
          child: const ViewFullPostingScreen(),
        )
      ],
      if (state.uri.path == mapViewRoute) ...[
        LostPawsBeamPage(
          path: mapViewRoute,
          popToNamed: mapViewRoute,
          child: const MapViewScreen(),
        )
      ],
      if (state.uri.path == profileRoute) ...[
        LostPawsBeamPage(
          path: profileRoute,
          popToNamed: homeRoute,
          child: const ProfileScreen(),
        )
      ],
      if (state.uri.path == savedPostsRoute) ...[
        LostPawsBeamPage(
          path: savedPostsRoute,
          popToNamed: profileRoute,
          child: const SavedPostsScreen(),
        )
      ],
      if (state.uri.path == charityRoute) ...[
        LostPawsBeamPage(
          path: charityRoute,
          popToNamed: homeRoute,
          child: const CharityScreen(),
        )
      ],
      if (state.uri.path == termsAndConditionsRoute) ...[
        LostPawsBeamPage(
          path: termsAndConditionsRoute,
          popToNamed: homeRoute,
          child: const TermsAndConditionsScreen(),
        )
      ],
      if (state.uri.path == privacyPolicyRoute) ...[
        LostPawsBeamPage(
          path: privacyPolicyRoute,
          popToNamed: homeRoute,
          child: const PrivacyPolicyScreen(),
        )
      ],
    ];
  }
}
