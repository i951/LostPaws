part of 'create_post_bloc.dart';

@freezed
class CreatePostEvent with _$CreatePostEvent {
  const factory CreatePostEvent.initial() = CreatePostInitial;

  const factory CreatePostEvent.typeChanged({
    required String postType,
  }) = CreatePostTypeChanged;

  const factory CreatePostEvent.titleChanged({
    required String title,
  }) = CreatePostTitleChanged;

  // TODO: events for uploading photos

  const factory CreatePostEvent.petTypeChanged({
    required String petType,
  }) = CreatePostPetTypeChanged;

  const factory CreatePostEvent.breedChanged({
    required String breed,
  }) = CreatePostBreedChanged;

  const factory CreatePostEvent.colourChanged({
    required String colour,
  }) = CreatePostColourChanged;

  const factory CreatePostEvent.weightChanged({
    required double weight,
  }) = CreatePostWeightChanged;

  // TODO: event for size of animal

  const factory CreatePostEvent.dateChanged({
    required DateTime date,
  }) = CreatePostDateChanged;

  const factory CreatePostEvent.getCurrentLocation() =
      CreatePostGetCurrentLocation;

  const factory CreatePostEvent.locationChanged({
    required LatLng location,
  }) = CreatePostLocationChanged;
}
