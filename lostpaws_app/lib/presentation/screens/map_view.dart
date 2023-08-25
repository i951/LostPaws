import 'package:beamer/beamer.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';
import 'package:permission_handler/permission_handler.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late bool serviceEnabled;
  late LocationPermission permission;
  ByteData? byteData;
  final _customInfoWindowController = CustomInfoWindowController();

  // Set to general coordinates in Metro Vancouver if location is not
  // enabled
  var userLocation = const LatLng(49.2820, -123.1171);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      byteData = await rootBundle.load('assets/images/location-pin.png');

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();

      if (serviceEnabled) {
        if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
          final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          userLocation = LatLng(
            position.latitude,
            position.longitude,
          );
        }
      } else {
        if (mounted) {
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      "Please enable location services",
                      style: const LostPawsText().primarySemiBold,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: Text(
                      "This will be used to find pet postings near you. Or, you can "
                      "search for a place by typing it into the search bar below.",
                      style: const LostPawsText().primaryRegularGrey,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                ConstColors.darkGreen),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: const BorderSide(
                                    color: ConstColors.darkGreen),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 8.0),
                            child: Text(
                              'No, thanks',
                              style: const LostPawsText().primaryRegularGreen,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            permission = await Geolocator.checkPermission();

                            if (permission == LocationPermission.denied) {
                              permission = await Geolocator.requestPermission();
                            }
                            if (permission ==
                                LocationPermission.deniedForever) {
                              await openAppSettings();
                            } else {
                              if (!serviceEnabled) {
                                await Geolocator.openLocationSettings();

                                if (mounted) {
                                  Navigator.of(context).pop();
                                }
                              }
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ConstColors.darkGreen),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: const BorderSide(
                                    color: ConstColors.darkGreen),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 8.0),
                            child: Text(
                              'Go to Settings',
                              style: const LostPawsText().primaryRegularWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lost pets near you",
              style: const LostPawsText().primaryTitleBoldWhite,
            ),
          ],
        ),
        toolbarOpacity: 1.0,
        toolbarHeight: getProportionateScreenHeight(80),
        backgroundColor: ConstColors.mediumGreen,
        foregroundColor: ConstColors.darkOrange,
        leading: IconButton(
          iconSize: 30.0,
          onPressed: () =>
              Beamer.of(context).beamToNamed(HomeLocations.homeRoute),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                GoogleMap(
                  onTap: (position) {
                    _customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    _customInfoWindowController.onCameraMove!();
                  },
                  onMapCreated: (GoogleMapController controller) async {
                    setState(() {});
                    _customInfoWindowController.googleMapController =
                        controller;
                  },
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                  scrollGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: userLocation,
                    zoom: 15.0,
                  ),
                  markers: getPostMarkers(byteData),
                  // onTap: (LatLng latlng) async {
                  //   print("tapped: $latlng");
                  // },
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  height: 75,
                  width: 150,
                  offset: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Makes a request to the server for postings near the user's location
  /// and returns the markers of posting locations to display on the map.
  Set<Marker> getPostMarkers(ByteData? iconBytes) {
    final Set<Marker> markers = {};

    if (iconBytes == null) {
      return markers;
    }

    const testPostPoints = [
      LatLng(49.161563, -123.152409),
      LatLng(49.166483, -123.120084),
      LatLng(49.161115, -123.133481),
      LatLng(49.152422, -123.125637),
    ];

    Uint8List locationPinBytes = iconBytes.buffer
        .asUint8List(iconBytes.offsetInBytes, iconBytes.lengthInBytes);

    for (var point in testPostPoints) {
      markers.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: LatLng(point.latitude, point.longitude),
          icon: BitmapDescriptor.fromBytes(locationPinBytes,
              size: const Size.square(20)),
          onTap: () {
            // Show posting preview popup
            _customInfoWindowController.addInfoWindow!(
              Column(
                children: getMarkerInfoWindow(
                    title: 'Golden Retriever', date: 'May 13, 2023'),
              ),
              LatLng(point.latitude, point.longitude),
            );
          },
        ),
      );
    }

    return markers;
  }

  List<Widget> getMarkerInfoWindow(
      {required String title, required String date}) {
    return [
      Expanded(
        child: GestureDetector(
          onTap: () {
            print("Bring user to full posting with title: $title");
          },
          child: Container(
            decoration: BoxDecoration(
              color: ConstColors.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 50,
                    // TODO: replace with image retrieved from server
                    child: Image.asset(
                      'assets/images/golden-retriever.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const LostPawsText().primarySemiBoldGreen,
                      ),
                      Text(
                        'Last seen:',
                        style: const LostPawsText().primarySmallerGrey,
                      ),
                      Text(
                        date,
                        style: const LostPawsText().primarySmallerGrey,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      Triangle.isosceles(
        edge: Edge.BOTTOM,
        child: Container(
          color: ConstColors.lightGreen,
          width: 20.0,
          height: 5.0,
        ),
      ),
    ];
  }
}
