part of main;

/// The [BeamerDelegate] to handle all routing for the MaterialApp.
///
/// Made private and part of main, so that only main.dart has access.
///
/// The pattern is that every Screen widget has a [BeamLocation] class as well.
/// To add a new Screen, create a new [BeamLocation] and add that to the
/// [beamLocations].
final _routerDelegate = BeamerDelegate(
  initialPath: UnauthenticatedLocations.signInRoute,
  locationBuilder: BeamerLocationBuilder(
    beamLocations: beamLocations,
  ),
);

/// The list of all possible Screens as BeamLocations.
///
/// Order is important, as pattern matching picks the first match. Deeper
/// links should be further down the list.
///
/// The [HomeLocations] should be towards the top, as that's the most common
/// match for logged-in sessions.
final List<BeamLocation> beamLocations = [
  // The screens for before they sign in:
  UnauthenticatedLocations(),
  // The landing page of the app
  HomeLocations(),
];
