import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lostpaws_app/data/models/location_last_seen.dart';
import 'package:lostpaws_app/data/models/pet_colour.dart';

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
    on<CreatePostPhotosChanged>(onCreatePostPhotosChanged);
    on<CreatePostPetTypeChanged>(onCreatePostPetTypeChanged);
    on<CreatePostBreedChanged>(onCreatePostBreedChanged);
    on<CreatePostColourChanged>(onCreatePostColourChanged);
    on<CreatePostWeightChanged>(onCreatePostWeightChanged);
    on<CreatePostSizeChanged>(onCreatePostSizeChanged);
    on<CreatePostDateChanged>(onCreatePostDateChanged);
    on<CreatePostLocationChanged>(onCreatePostLocationChanged);
    on<CreatePostDescriptionChanged>(onCreatePostDescriptionChanged);
    on<CreatePostPhoneChanged>(onCreatePostPhoneChanged);
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

  void onCreatePostPhotosChanged(
    CreatePostPhotosChanged event,
    Emitter<CreatePostState> emit,
  ) {
    print("Bloc is uploading photos...");
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
  ) {
    emit(state.copyWith(colour: event.colour));
  }

  void onCreatePostWeightChanged(
    CreatePostWeightChanged event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(weight: event.weight));
  }

  void onCreatePostSizeChanged(
    CreatePostSizeChanged event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(size: event.size));
  }

  void onCreatePostDateChanged(
    CreatePostDateChanged event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(dateLastSeen: event.date));
  }

  Future<void> onCreatePostLocationChanged(
    CreatePostLocationChanged event,
    Emitter<CreatePostState> emit,
  ) async {
    // This method might return more than one result, but we will keep the
    // first one, which is the most accurate address based on the coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(
      event.location.latitude,
      event.location.longitude,
    );

    final address = placemarks.first;

    // If any fields are null, set it as an empty string
    emit(
      state.copyWith(
        locationLastSeen: LocationLastSeen(
          latitude: event.location.latitude,
          longitude: event.location.longitude,
          street: address.street ?? '',
          city: address.locality ?? '',
          regionalDistrict: address.subAdministrativeArea ?? '',
          province: address.administrativeArea ?? '',
          country: address.country ?? '',
          postalCode: address.postalCode ?? '',
        ),
      ),
    );
  }

  void onCreatePostDescriptionChanged(
    CreatePostDescriptionChanged event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void onCreatePostPhoneChanged(
    CreatePostPhoneChanged event,
    Emitter<CreatePostState> emit,
  ) {
    switch (event.phonePart) {
      case 0:
        emit(state.copyWith(contactPhoneStart: event.phone));
        break;
      case 1:
        emit(state.copyWith(contactPhoneMiddle: event.phone));
        break;
      case 2:
        emit(state.copyWith(contactPhoneEnd: event.phone));
        break;
      default:
        throw UnimplementedError('Invalid value for variable phonePart');
    }
  }
}
