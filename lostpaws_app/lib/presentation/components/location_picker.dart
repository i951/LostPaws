import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lostpaws_app/business/bloc/create_post_bloc.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class LocationPicker extends StatefulWidget {
  final double dialogWidth;
  final double dialogHeight;
  final LatLng? userLocation;

  const LocationPicker({
    super.key,
    required this.dialogWidth,
    required this.dialogHeight,
    required this.userLocation,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Where was the animal last seen?",
              style: const LostPawsText().primarySemiBold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Drag the map around to place the pin on the location where you last saw the animal",
              style: const LostPawsText().primaryRegularGrey,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<CreatePostBloc, CreatePostState>(
                builder: (context, state) {
                  return Container(
                    width: widget.dialogWidth - defaultPadding * 2,
                    height: widget.dialogHeight / 2,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(45),
                      border: Border.all(
                        color: ConstColors.mediumGreen,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(45),
                      ),
                      child: GoogleMap(
                        scrollGesturesEnabled: true,
                        rotateGesturesEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            widget.userLocation!.latitude,
                            widget.userLocation!.longitude,
                          ),
                          zoom: 15.0,
                        ),
                        onTap: (LatLng argument) {
                          context.read<CreatePostBloc>().add(
                              CreatePostEvent.locationChanged(
                                  location: argument));
                        },
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "Location: AREA, CITY",
                      style: LostPawsText().primaryRegularGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              SizedBox(
                width: widget.dialogWidth / 3,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: ConstColors.darkGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "Done",
                      style: const LostPawsText().primaryRegularWhite,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
