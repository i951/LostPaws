part of 'create_post_bloc.dart';

enum Status { initial, loading, complete, failure }

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    @Default(Status.initial) Status status,
    PostTypeOption? postType,
    @Default("") String postTitle,
    @Default([]) List<String> photoPaths,
    PetTypeOption? petType,
    String? breed,
    PetColour? colour,
    double? weight,
    String? size,
    DateTime? dateLastSeen,
    LocationLastSeen? locationLastSeen,
    String? description,
    String? contactEmail,
    String? contactPhoneStart,
    String? contactPhoneMiddle,
    String? contactPhoneEnd,
  }) = _CreatePostState;
}
