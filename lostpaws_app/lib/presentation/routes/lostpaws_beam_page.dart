// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:beamer/beamer.dart';

class LostPawsBeamPage extends BeamPage {
  /// A convenience class to ensure all [BeamPage]s in the app are consistent.
  ///
  /// The [path] is for this page's URI, and must be unique as it is being used
  /// as a Key for this page.
  ///
  /// [popToNamed] should be supplied for every page except the home page. When
  /// the user taps back, it should be declared what route they pop back to.
  ///
  /// The [child] is the screen, typically a fullscreen Widget.
  ///
  /// Example:
  ///
  /// ```
  /// LostPawsBeamPage(
  ///   path: secondPageRoute,
  ///   popToNamed: firstPageRoute,
  ///   child: SecondPageScreen(),
  /// );
  /// ```

  LostPawsBeamPage({
    required String path,
    required super.popToNamed,
    super.type,
    required Widget child,
    bool enableSwipeToGoBack = false,
  }) : super(
          key: ValueKey(path),
          child: enableSwipeToGoBack ? child : _WillPopWrapper(child: child),
        );
}

/// A convenience class to wrap all of our screens in.
///
/// This prevents users from being able to use gestures to navigate back.
/// [LostPawsBeamPage] isn't a widget, so has no build method, which WillPopScope
/// needs for this `onWillPop` callback.
class _WillPopWrapper extends StatelessWidget {
  final Widget child;

  const _WillPopWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: child,
    );
  }
}
