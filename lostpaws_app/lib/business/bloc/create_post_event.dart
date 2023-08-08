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

  const factory CreatePostEvent.uploadPhotos({required List<String> photos}) =
      CreatePostPhotosChanged;

  const factory CreatePostEvent.petTypeChanged({
    required String petType,
  }) = CreatePostPetTypeChanged;

  const factory CreatePostEvent.breedChanged({
    required String breed,
  }) = CreatePostBreedChanged;

  const factory CreatePostEvent.colourChanged({
    required PetColour colour,
  }) = CreatePostColourChanged;

  const factory CreatePostEvent.weightChanged({
    required String weight,
  }) = CreatePostWeightChanged;

  const factory CreatePostEvent.sizeChanged({
    required String size,
  }) = CreatePostSizeChanged;

  const factory CreatePostEvent.dateChanged({
    required DateTime date,
  }) = CreatePostDateChanged;

  const factory CreatePostEvent.locationChanged({
    required LatLng location,
  }) = CreatePostLocationChanged;

  const factory CreatePostEvent.descriptionChanged({
    required String description,
  }) = CreatePostDescriptionChanged;

  const factory CreatePostEvent.phoneChanged({
    required String phone,

    /// An integer value representing which part of a 10-digit phone number
    /// [phone] refers to.
    ///
    /// 0 refers to the first three digits, 1 refers to the following three
    /// digits, and 2 refers to the last four digits in a 10-digit phone number.
    required int phonePart,
  }) = CreatePostPhoneChanged;

  const factory CreatePostEvent.setAutovalidate() = CreatePostSetAutovalidate;

  const factory CreatePostEvent.sendToServer({
    required String? userName,
    required String userId,
    required String contactEmail,
  }) = CreatePostSendToServer;
}
