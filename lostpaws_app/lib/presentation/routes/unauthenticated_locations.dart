// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:beamer/beamer.dart';
import 'package:lostpaws_app/presentation/routes/lostpaws_beam_page.dart';
import 'package:lostpaws_app/presentation/screens/create_account.dart';
import 'package:lostpaws_app/presentation/screens/forgot_password.dart';
import 'package:lostpaws_app/presentation/screens/privacy_policy.dart';
import 'package:lostpaws_app/presentation/screens/sign_in.dart';
import 'package:lostpaws_app/presentation/screens/terms_and_conditions.dart';

/// The [BeamLocation] for the screens visible without logging in.
///
/// The [SignInScreen] is at the root of every stack of screens, with screens
/// like the Forgot Password flow, the Sign Up flow, and 2FA authentication
/// sitting on top of it.
///
/// Swipe-to-go-back is mostly disabled for these screens since they have nested
/// Beamers and nothing to pop back to.
class UnauthenticatedLocations extends BeamLocation<BeamState> {
  /// beamToNamed location for the [SignInScreen]
  static const String signInRoute = '/';

  /// beamToNamed location for the [ForgotPasswordFormScreen]
  static const String forgotFormRoute = '/forgot_password_form';

  /// beamToNamed location for the [CreateAccountScreen]
  static const String createAccountRoute = '/create_account';

  /// beamToNamed location for the [TermsAndConditionsScreen]
  static const String termsAndConditionsRoute = '/terms_and_conditions';

  /// beamToNamed location for the [PrivacyPolicyScreen]
  static const String privacyPolicyRoute = '/privacy_policy';

  @override
  List<Pattern> get pathPatterns => _pathPatterns;

  static const List<Pattern> _pathPatterns = [
    //Routes with no nested navigators can be added by path directly:
    signInRoute,
    forgotFormRoute,
    createAccountRoute,
    termsAndConditionsRoute,
    privacyPolicyRoute,
  ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      LostPawsBeamPage(
        path: signInRoute,
        popToNamed: null,
        child: SignInScreen(),
      ),
      if (state.uri.path == forgotFormRoute) ...[
        LostPawsBeamPage(
          path: forgotFormRoute,
          popToNamed: null,
          child: const ForgotPasswordScreen(),
        ),
      ],
      if (state.uri.path.contains(termsAndConditionsRoute)) ...[
        LostPawsBeamPage(
          path: termsAndConditionsRoute,
          popToNamed: createAccountRoute,
          child: const TermsAndConditionsScreen(),
        ),
      ],
      if (state.uri.path.contains(privacyPolicyRoute)) ...[
        LostPawsBeamPage(
          path: privacyPolicyRoute,
          popToNamed: createAccountRoute,
          child: const PrivacyPolicyScreen(),
        ),
      ],
      if (state.uri.path == createAccountRoute) ...[
        LostPawsBeamPage(
          path: forgotFormRoute,
          popToNamed: null,
          child: const CreateAccountScreen(),
        ),
      ],
    ];
  }
}
