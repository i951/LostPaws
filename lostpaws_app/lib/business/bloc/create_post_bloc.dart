import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
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
    on<CreatePostSendToServer>(onCreatePostSendToServer);
    on<CreatePostSetAutovalidate>(onCreatePostSetAutovalidate);
  }

  void onCreatePostInitial(
    CreatePostInitial event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(status: CreatePostStatus.initial));
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
  }

  void onCreatePostTitleChanged(
    CreatePostTitleChanged event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(postTitle: event.title));
  }

  void onCreatePostPhotosChanged(
    CreatePostPhotosChanged event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(photoPaths: event.photos));
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
  ) {
    emit(state.copyWith(breed: event.breed));
  }

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

  void onCreatePostSendToServer(
    CreatePostSendToServer event,
    Emitter<CreatePostState> emit,
  ) {
    String? fullContactPhone;

    // Checking for a valid phone number if user provides a number
    if (state.contactPhoneStart == null &&
        state.contactPhoneMiddle == null &&
        state.contactPhoneEnd == null) {
      // Here the user has chosen to not provide a number
      fullContactPhone = null;
    } else if (state.contactPhoneStart != null &&
        state.contactPhoneStart!.isNotEmpty &&
        state.contactPhoneMiddle != null &&
        state.contactPhoneMiddle!.isNotEmpty &&
        state.contactPhoneEnd != null &&
        state.contactPhoneEnd!.isNotEmpty) {
      // Here the user has filled in all the phone number fields, so
      // check the values are valid numbers
      try {
        final start = int.parse(state.contactPhoneStart!);
        final middle = int.parse(state.contactPhoneMiddle!);
        final end = int.parse(state.contactPhoneEnd!);

        // Check the length of the digits provided
        if (start < 100 || start > 999 || middle < 100 || middle > 999) {
          emit(state.copyWith(
              status: CreatePostStatus.invalidPhone,
              error: "Please ensure you provide a valid phone number."));
        }
        if (end < 1000 || end > 9999) {
          emit(state.copyWith(
              status: CreatePostStatus.invalidPhone,
              error: "Please ensure you provide a valid phone number."));
        }
      } catch (_) {
        emit(state.copyWith(
          status: CreatePostStatus.invalidPhone,
          error: "Please enter only numerical values for your phone number.",
        ));
      }

      fullContactPhone = state.contactPhoneStart! +
          state.contactPhoneMiddle! +
          state.contactPhoneEnd!;
    } else {
      // Otherwise, the user has forgotten to fill in one of the phone number
      // fields
      emit(state.copyWith(
          status: CreatePostStatus.invalidPhone,
          error: "Please ensure all phone number fields are filled in."));
    }

    emit(state.copyWith(
      status: CreatePostStatus.submissionInProgress,
      error: null,
    ));

    final f = DateFormat('yyyy-MM-dd');
    final formattedDate = f.format(
        state.dateLastSeen == null ? DateTime.now() : state.dateLastSeen!);

    final jsonString = jsonEncode({
      "userID": event.userId,
      "userName": event.userName,
      "postType": state.postType?.value,
      "postTitle": state.postTitle,
      "photos": state.photoPaths,
      "petType": state.petType?.value,
      "breed": state.breed,
      "colour": state.colour,
      "weight": state.weight,
      "size": state.size,
      "dateLastSeen": formattedDate,
      "locationLastSeen": state.locationLastSeen,
      "description": state.description,
      "contactEmail": event.contactEmail,
      "contactPhone": fullContactPhone,
    });

    print(jsonString);

    emit(state.copyWith(
      status: CreatePostStatus.submissionSuccess,
      error: null,
    ));
  }

  void onCreatePostSetAutovalidate(
    CreatePostSetAutovalidate event,
    Emitter<CreatePostState> emit,
  ) {
    if (!state.autoValidate ||
        state.status == CreatePostStatus.submissionFailure) {
      emit(state.copyWith(autoValidate: true));
    }
  }
}
