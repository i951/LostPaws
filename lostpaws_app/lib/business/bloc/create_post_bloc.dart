import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';
part 'create_post_bloc.freezed.dart';

enum PostTypeOption {
  lost("LOST"),
  sighting("SIGHTING");

  final String value;

  const PostTypeOption(this.value);
}

enum PetTypeOption {
  dog("DOG"),
  cat("CAT"),
  bird("BIRD"),
  bunny("BUNNY"),
  reptile("REPTILE"),
  amphibian("AMPHIBIAN"),
  rodent("RODENT"),
  other("OTHER");

  final String value;

  const PetTypeOption(this.value);
}

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(const CreatePostState()) {
    on<CreatePostInitial>(onCreatePostInitial);
    on<CreatePostTypeChanged>(onCreatePostTypeChanged);
    on<CreatePostTitleChanged>(onCreatePostTitleChanged);
    on<CreatePostPetTypeChanged>(onCreatePostPetTypeChanged);
    on<CreatePostBreedChanged>(onCreatePostBreedChanged);
    on<CreatePostColourChanged>(onCreatePostColourChanged);
    on<CreatePostWeightChanged>(onCreatePostWeightChanged);
    on<CreatePostDateChanged>(onCreatePostDateChanged);
    on<CreatePostGetCurrentLocation>(onCreatePostGetCurrentLocation);
    on<CreatePostLocationChanged>(onCreatePostLocationChanged);
  }

  void onCreatePostInitial(
    CreatePostInitial event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(status: Status.initial));
  }

  void onCreatePostTypeChanged(
    CreatePostTypeChanged event,
    Emitter<CreatePostState> emit,
  ) {
    if (event.postType == PostTypeOption.sighting.value) {
      emit(state.copyWith(postType: PostTypeOption.sighting));
    } else if (event.postType == PostTypeOption.lost.value) {
      emit(state.copyWith(postType: PostTypeOption.lost));
    } else {
      throw UnimplementedError("Post type not supported");
    }

    print("state's post type: ${state.postType}");
  }

  void onCreatePostTitleChanged(
    CreatePostTitleChanged event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(postTitle: event.title));

    print("state's title: ${state.postTitle}");
  }

  void onCreatePostPetTypeChanged(
    CreatePostPetTypeChanged event,
    Emitter<CreatePostState> emit,
  ) {
    if (event.petType == PetTypeOption.dog.value) {
      emit(state.copyWith(petType: PetTypeOption.dog));
    } else if (event.petType == PetTypeOption.cat.value) {
      emit(state.copyWith(petType: PetTypeOption.cat));
    } else if (event.petType == PetTypeOption.bird.value) {
      emit(state.copyWith(petType: PetTypeOption.bird));
    } else if (event.petType == PetTypeOption.bunny.value) {
      emit(state.copyWith(petType: PetTypeOption.bunny));
    } else if (event.petType == PetTypeOption.reptile.value) {
      emit(state.copyWith(petType: PetTypeOption.reptile));
    } else if (event.petType == PetTypeOption.amphibian.value) {
      emit(state.copyWith(petType: PetTypeOption.amphibian));
    } else if (event.petType == PetTypeOption.rodent.value) {
      emit(state.copyWith(petType: PetTypeOption.rodent));
    } else if (event.petType == PetTypeOption.other.value) {
      emit(state.copyWith(petType: PetTypeOption.other));
    } else {
      throw UnimplementedError("Post type not supported");
    }

    print("state's pet type: ${state.petType}");
  }

  void onCreatePostBreedChanged(
    CreatePostBreedChanged event,
    Emitter<CreatePostState> emit,
  ) {}

  void onCreatePostColourChanged(
    CreatePostColourChanged event,
    Emitter<CreatePostState> emit,
  ) {}

  void onCreatePostWeightChanged(
    CreatePostWeightChanged event,
    Emitter<CreatePostState> emit,
  ) {}

  void onCreatePostDateChanged(
    CreatePostDateChanged event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(dateLastSeen: event.date));
    print("Date last seen: ${state.dateLastSeen}");
  }

  Future<void> onCreatePostGetCurrentLocation(
    CreatePostGetCurrentLocation event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      emit(
        state.copyWith(
          userLocation: LatLng(position.latitude, position.longitude),
          status: Status.complete,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          userLocation: LatLng(49.2346212, -123.1635604),
          status: Status.complete,
        ),
      );
    }

    print(state.userLocation);
  }

  void onCreatePostLocationChanged(
    CreatePostLocationChanged event,
    Emitter<CreatePostState> emit,
  ) {
    // emit(state.copyWith(location: event.location));
  }
}
